const mockLedger = {
  _id: '60d5ec49c6d1a21e483e5894',
  madrasaId: '60d5ec49c6d1a21e483e5896',
  studentId: '60d5ec49c6d1a21e483e5892',
  academicYear: '2026-2027',
  invoices: [],
  save: jest.fn().mockResolvedValue(),
};

jest.mock('../../src/models/FeeLedger', () => {
  const mockModel = function (data) {
    Object.assign(this, data, mockLedger);
    this._id = mockLedger._id;
    this.save = jest.fn().mockResolvedValue(this);
  };
  mockModel.findOne = jest.fn();
  mockModel.prototype.save = jest.fn().mockResolvedValue({});
  return mockModel;
});

jest.mock('../../src/models/Student', () => {
  const mockModel = function () {};
  mockModel.findOne = jest.fn();
  mockModel.prototype.save = jest.fn();
  return mockModel;
});

const FeeLedger = require('../../src/models/FeeLedger');
const Student = require('../../src/models/Student');
const feeService = require('../../src/services/feeService');

const MADRASA_ID = '60d5ec49c6d1a21e483e5896';

describe('Fee Service', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('createInvoice', () => {
    const invoiceData = {
      studentId: '60d5ec49c6d1a21e483e5892',
      academicYear: '2026-2027',
      invoiceNo: 'INV-001',
      title: 'August Tuition Fee',
      amount: 2000,
      dueDate: new Date('2026-08-15'),
    };

    it('creates an invoice in the student ledger', async () => {
      Student.findOne.mockResolvedValue({ _id: invoiceData.studentId });
      FeeLedger.findOne.mockResolvedValue(null);

      const result = await feeService.createInvoice(MADRASA_ID, invoiceData);

      expect(Student.findOne).toHaveBeenCalledWith({
        _id: invoiceData.studentId,
        madrasaId: MADRASA_ID,
        isDeleted: false,
      });
      expect(result).toBeDefined();
      expect(result.save).toHaveBeenCalled();
    });

    it('rejects duplicate invoice numbers', async () => {
      Student.findOne.mockResolvedValue({ _id: invoiceData.studentId });
      FeeLedger.findOne.mockResolvedValue(mockLedger);

      await expect(feeService.createInvoice(MADRASA_ID, invoiceData)).rejects.toThrow(
        `Invoice number ${invoiceData.invoiceNo} already exists in the system database.`
      );
      await expect(feeService.createInvoice(MADRASA_ID, invoiceData)).rejects.toMatchObject({
        statusCode: 409,
        code: 'DUPLICATE_INVOICE',
      });
    });

    it('throws STUDENT_NOT_FOUND if student does not exist', async () => {
      Student.findOne.mockResolvedValue(null);

      await expect(feeService.createInvoice(MADRASA_ID, invoiceData)).rejects.toMatchObject({
        statusCode: 404,
        code: 'STUDENT_NOT_FOUND',
      });
    });

    it('appends invoice to existing ledger when one already exists', async () => {
      const existingLedger = {
        ...mockLedger,
        invoices: [{ invoiceNo: 'INV-000', title: 'Previous', amount: 1000, status: 'Paid' }],
        save: jest.fn().mockResolvedValue({ invoices: [] }),
      };
      Student.findOne.mockResolvedValue({ _id: invoiceData.studentId });
      FeeLedger.findOne
        .mockResolvedValueOnce(null)
        .mockResolvedValueOnce(existingLedger);

      const result = await feeService.createInvoice(MADRASA_ID, invoiceData);

      expect(result).toBeDefined();
    });
  });

  describe('getStudentLedger', () => {
    it('returns the student ledger for the given madrasa, student, and academic year', async () => {
      const populatedLedger = { ...mockLedger, invoices: [{ invoiceNo: 'INV-001', amount: 2000 }] };
      FeeLedger.findOne.mockReturnValue({
        populate: jest.fn().mockResolvedValue(populatedLedger),
      });

      const result = await feeService.getStudentLedger(
        MADRASA_ID,
        mockLedger.studentId,
        '2026-2027'
      );

      expect(FeeLedger.findOne).toHaveBeenCalledWith({
        madrasaId: MADRASA_ID,
        studentId: mockLedger.studentId,
        academicYear: '2026-2027',
      });
      expect(result.invoices).toHaveLength(1);
    });

    it('returns null when no ledger exists', async () => {
      FeeLedger.findOne.mockReturnValue({
        populate: jest.fn().mockResolvedValue(null),
      });

      const result = await feeService.getStudentLedger(MADRASA_ID, 'other-student', '2026-2027');
      expect(result).toBeNull();
    });
  });

  describe('recordPayment', () => {
    const paymentData = {
      invoiceNo: 'INV-001',
      amountPaid: 2000,
      paymentMethod: 'Cash',
      transactionId: 'TXN-001',
    };

    it('records a partial payment on an invoice', async () => {
      const invoice = {
        invoiceNo: 'INV-001',
        amount: 5000,
        paidAmount: 0,
        status: 'Unpaid',
        payments: [],
      };
      const ledger = {
        ...mockLedger,
        invoices: [invoice],
        save: jest.fn().mockResolvedValue(),
      };
      FeeLedger.findOne.mockResolvedValue(ledger);

      const result = await feeService.recordPayment(MADRASA_ID, { ...paymentData, amountPaid: 2000 });

      expect(result.invoices[0].paidAmount).toBe(2000);
      expect(result.invoices[0].status).toBe('Partially_Paid');
      expect(result.invoices[0].payments).toHaveLength(1);
      expect(result.invoices[0].payments[0].transactionId).toBe('TXN-001');
    });

    it('marks invoice as Paid when fully paid', async () => {
      const invoice = {
        invoiceNo: 'INV-001',
        amount: 2000,
        paidAmount: 0,
        status: 'Unpaid',
        payments: [],
      };
      const ledger = {
        ...mockLedger,
        invoices: [invoice],
        save: jest.fn().mockResolvedValue(),
      };
      FeeLedger.findOne.mockResolvedValue(ledger);

      const result = await feeService.recordPayment(MADRASA_ID, paymentData);

      expect(result.invoices[0].paidAmount).toBe(2000);
      expect(result.invoices[0].status).toBe('Paid');
    });

    it('throws INVOICE_NOT_FOUND when invoice does not exist', async () => {
      FeeLedger.findOne.mockResolvedValue(null);

      await expect(feeService.recordPayment(MADRASA_ID, paymentData)).rejects.toMatchObject({
        statusCode: 404,
        code: 'INVOICE_NOT_FOUND',
      });
    });
  });
});
