const { z } = require('zod');

const createInvoiceSchema = z.object({
  studentId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Student ID format'),
  academicYear: z.string().regex(/^\d{4}-\d{4}$/, 'Academic year must be YYYY-YYYY format'),
  invoiceNo: z.string().trim().min(3),
  title: z.string().trim().min(3),
  amount: z.number().min(0),
  dueDate: z.string().transform(val => new Date(val)),
});

const recordPaymentSchema = z.object({
  invoiceNo: z.string().trim().min(3),
  amountPaid: z.number().positive(),
  paymentMethod: z.enum(['Stripe', 'Razorpay', 'Cash', 'BankTransfer']),
  transactionId: z.string().trim().min(3),
});

const ledgerQuerySchema = z.object({
  academicYear: z.string().regex(/^\d{4}-\d{4}$/, 'Academic year must be YYYY-YYYY format'),
});

module.exports = { createInvoiceSchema, recordPaymentSchema, ledgerQuerySchema };
