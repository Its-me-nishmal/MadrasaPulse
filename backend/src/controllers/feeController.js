const { createInvoiceSchema, recordPaymentSchema, ledgerQuerySchema } = require('../validators/feeValidator');
const feeService = require('../services/feeService');
const { catchError } = require('../utils/errorHandler');

/**
 * Create a new fee invoice and post it to the student's ledger
 * @param {import('express').Request} req - Express request object with validated invoice data
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const createInvoice = async (req, res, next) => {
  try {
    const validatedBody = createInvoiceSchema.parse(req.body);
    const madrasaId = req.user.madrasaId;
    const ledger = await feeService.createInvoice(madrasaId, validatedBody);
    res.status(201).json({ success: true, message: 'Invoice successfully generated and posted to student ledger.', data: ledger });
  } catch (error) {
    catchError(error, res, next);
  }
};

/**
 * Retrieve the fee ledger for a student in a given academic year
 * @param {import('express').Request} req - Express request object with studentId param and academicYear query
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const getStudentLedger = async (req, res, next) => {
  try {
    const { studentId } = req.params;
    const { academicYear } = ledgerQuerySchema.parse(req.query);
    const madrasaId = req.user.madrasaId;
    const ledger = await feeService.getStudentLedger(madrasaId, studentId, academicYear);
    if (!ledger) {
      return res.status(200).json({ success: true, data: { madrasaId, studentId, academicYear, invoices: [] } });
    }
    res.status(200).json({ success: true, data: ledger });
  } catch (error) {
    catchError(error, res, next);
  }
};

/**
 * Record a payment against an existing invoice
 * @param {import('express').Request} req - Express request object with validated payment data
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const recordPayment = async (req, res, next) => {
  try {
    const validatedBody = recordPaymentSchema.parse(req.body);
    const madrasaId = req.user.madrasaId;
    const ledger = await feeService.recordPayment(madrasaId, validatedBody);
    res.status(200).json({ success: true, message: 'Payment successfully captured and updated.', data: ledger });
  } catch (error) {
    catchError(error, res, next);
  }
};

module.exports = { createInvoice, getStudentLedger, recordPayment };
