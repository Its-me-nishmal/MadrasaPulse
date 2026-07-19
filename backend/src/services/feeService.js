const FeeLedger = require('../models/FeeLedger');
const Student = require('../models/Student');

/**
 * Create a new fee invoice for a student and add it to their ledger
 * @param {String} madrasaId - The madrasa tenant ID
 * @param {Object} data - Invoice data with studentId, invoiceNo, title, amount, dueDate, academicYear
 * @returns {Promise<Object>} The updated fee ledger document
 */
const createInvoice = async (madrasaId, data) => {
  const student = await Student.findOne({ _id: data.studentId, madrasaId, isDeleted: false });
  if (!student) {
    const error = new Error('Student profile not found or belongs to another tenant.');
    error.statusCode = 404;
    error.code = 'STUDENT_NOT_FOUND';
    throw error;
  }
  const duplicateInvoice = await FeeLedger.findOne({
    madrasaId,
    'invoices.invoiceNo': data.invoiceNo,
  });
  if (duplicateInvoice) {
    const error = new Error(`Invoice number ${data.invoiceNo} already exists in the system database.`);
    error.statusCode = 409;
    error.code = 'DUPLICATE_INVOICE';
    throw error;
  }
  let ledger = await FeeLedger.findOne({ studentId: data.studentId, academicYear: data.academicYear });
  if (!ledger) {
    ledger = new FeeLedger({
      madrasaId,
      studentId: data.studentId,
      academicYear: data.academicYear,
      invoices: [],
    });
  }
  ledger.invoices.push({
    invoiceNo: data.invoiceNo,
    title: data.title,
    amount: data.amount,
    dueDate: data.dueDate,
    status: 'Unpaid',
    paidAmount: 0,
    payments: [],
  });
  await ledger.save();
  return ledger;
};

/**
 * Retrieve a student's fee ledger for a given academic year
 * @param {String} madrasaId - The madrasa tenant ID
 * @param {String} studentId - The student's MongoDB ObjectId
 * @param {String} academicYear - The academic year string (e.g. 2024-2025)
 * @returns {Promise<Object|null>} The fee ledger document with populated student data
 */
const getStudentLedger = async (madrasaId, studentId, academicYear) => {
  const ledger = await FeeLedger.findOne({
    madrasaId,
    studentId,
    academicYear,
  }).populate('studentId', 'firstName lastName admissionNo rollNo');
  return ledger;
};

/**
 * Record a payment against an invoice, updating paid amount and status
 * @param {String} madrasaId - The madrasa tenant ID
 * @param {Object} data - Payment data with invoiceNo, transactionId, amountPaid, paymentMethod
 * @returns {Promise<Object>} The updated fee ledger document
 */
const recordPayment = async (madrasaId, data) => {
  const ledger = await FeeLedger.findOne({
    madrasaId,
    'invoices.invoiceNo': data.invoiceNo,
  });
  if (!ledger) {
    const error = new Error('Invoice not found.');
    error.statusCode = 404;
    error.code = 'INVOICE_NOT_FOUND';
    throw error;
  }
  const invoice = ledger.invoices.find(inv => inv.invoiceNo === data.invoiceNo);
  if (!invoice) {
    const error = new Error('Invoice not found.');
    error.statusCode = 404;
    error.code = 'INVOICE_NOT_FOUND';
    throw error;
  }
  invoice.payments.push({
    transactionId: data.transactionId,
    amountPaid: data.amountPaid,
    paymentMethod: data.paymentMethod,
    paidAt: new Date(),
  });
  invoice.paidAmount += data.amountPaid;
  if (invoice.paidAmount >= invoice.amount) {
    invoice.status = 'Paid';
  } else {
    invoice.status = 'Partially_Paid';
  }
  await ledger.save();
  return ledger;
};

module.exports = { createInvoice, getStudentLedger, recordPayment };
