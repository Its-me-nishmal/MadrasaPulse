const { z } = require('zod');
const mongoose = require('mongoose');
const FeeLedger = require('../models/FeeLedger');
const Student = require('../models/Student');

// Payload validation schemas
const createInvoiceSchema = z.object({
  studentId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Student ID format'),
  academicYear: z.string().regex(/^\d{4}-\d{4}$/, 'Academic year must be YYYY-YYYY format'),
  invoiceNo: z.string().trim().min(3),
  title: z.string().trim().min(3),
  amount: z.number().min(0),
  dueDate: z.string().transform(val => new Date(val)),
});

const recordPaymentSchema = z.object({
  invoiceNo: z.string().trim(),
  amountPaid: z.number().positive(),
  paymentMethod: z.enum(['Stripe', 'Razorpay', 'Cash', 'BankTransfer']),
  transactionId: z.string().trim().min(3),
});

/**
 * Generate and assign a new invoice to a student's ledger
 */
const createInvoice = async (req, res, next) => {
  try {
    const { studentId, academicYear, invoiceNo, title, amount, dueDate } = createInvoiceSchema.parse(req.body);
    const madrasaId = req.user.madrasaId;

    // Verify the student profile exists under the tenant context
    const student = await Student.findOne({ _id: studentId, madrasaId, isDeleted: false });
    if (!student) {
      return res.status(404).json({
        success: false,
        error: {
          code: 'STUDENT_NOT_FOUND',
          message: 'Student profile not found or belongs to another tenant.',
        },
      });
    }

    // Verify invoice number is unique across this madrasa tenant
    const duplicateInvoice = await FeeLedger.findOne({
      madrasaId,
      'invoices.invoiceNo': invoiceNo,
    });

    if (duplicateInvoice) {
      return res.status(409).json({
        success: false,
        error: {
          code: 'DUPLICATE_INVOICE',
          message: `Invoice number ${invoiceNo} already exists in the system database.`,
        },
      });
    }

    // Find the ledger bucket or initialize it
    let ledger = await FeeLedger.findOne({ studentId, academicYear });

    if (!ledger) {
      ledger = new FeeLedger({
        madrasaId,
        studentId,
        academicYear,
        invoices: [],
      });
    }

    // Append new invoice
    ledger.invoices.push({
      invoiceNo,
      title,
      amount,
      dueDate,
      status: 'Unpaid',
      paidAmount: 0,
      payments: [],
    });

    await ledger.save();

    res.status(201).json({
      success: true,
      message: 'Invoice successfully generated and posted to student ledger.',
      data: ledger,
    });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({
        success: false,
        error: {
          code: 'VALIDATION_FAILED',
          message: 'Invalid request payload parameters.',
          details: error.errors.map(err => ({ field: err.path.join('.'), issue: err.message })),
        },
      });
    }
    next(error);
  }
};

/**
 * Fetch detailed financial ledger history for a student
 */
const getStudentLedger = async (req, res, next) => {
  try {
    const { studentId } = req.params;
    const { academicYear } = req.query;
    const madrasaId = req.user.madrasaId;

    if (!academicYear || !/^\d{4}-\d{4}$/.test(academicYear)) {
      return res.status(400).json({
        success: false,
        error: {
          code: 'VALIDATION_FAILED',
          message: 'Query parameter academicYear (YYYY-YYYY) is required.',
        },
      });
    }

    const ledger = await FeeLedger.findOne({
      madrasaId,
      studentId: new mongoose.Types.ObjectId(studentId),
      academicYear,
    }).populate('studentId', 'firstName lastName admissionNo rollNo');

    if (!ledger) {
      return res.status(200).json({
        success: true,
        data: {
          madrasaId,
          studentId,
          academicYear,
          invoices: [],
        },
      });
    }

    res.status(200).json({
      success: true,
      data: ledger,
    });
  } catch (error) {
    next(error);
  }
};

/**
 * Record payment transaction against an invoice
 */
const recordPayment = async (req, res, next) => {
  try {
    const { invoiceNo, amountPaid, paymentMethod, transactionId } = recordPaymentSchema.parse(req.body);
    const madrasaId = req.user.madrasaId;

    // Find the ledger containing the target invoiceNo
    const ledger = await FeeLedger.findOne({
      madrasaId,
      'invoices.invoiceNo': invoiceNo,
    });

    if (!ledger) {
      return res.status(404).json({
        success: false,
        error: {
          code: 'INVOICE_NOT_FOUND',
          message: `Invoice number ${invoiceNo} not found.`,
        },
      });
    }

    // Locate the invoice inside the invoices array
    const invoice = ledger.invoices.find(inv => inv.invoiceNo === invoiceNo);

    // Append transaction log
    invoice.payments.push({
      transactionId,
      amountPaid,
      paymentMethod,
      paidAt: new Date(),
    });

    // Update balance
    invoice.paidAmount += amountPaid;

    if (invoice.paidAmount >= invoice.amount) {
      invoice.status = 'Paid';
    } else {
      invoice.status = 'Partially_Paid';
    }

    await ledger.save();

    res.status(200).json({
      success: true,
      message: 'Payment successfully captured and updated.',
      data: ledger,
    });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({
        success: false,
        error: {
          code: 'VALIDATION_FAILED',
          message: 'Invalid request payload parameters.',
          details: error.errors.map(err => ({ field: err.path.join('.'), issue: err.message })),
        },
      });
    }
    next(error);
  }
};

module.exports = {
  createInvoice,
  getStudentLedger,
  recordPayment,
};
