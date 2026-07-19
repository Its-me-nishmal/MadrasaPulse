const mongoose = require('mongoose');

const PaymentSchema = new mongoose.Schema({
  transactionId: {
    type: String,
    required: true,
  },
  amountPaid: {
    type: Number,
    required: true,
    min: 0,
  },
  paymentMethod: {
    type: String,
    required: true,
    enum: ['Stripe', 'Razorpay', 'Cash', 'BankTransfer'],
  },
  paidAt: {
    type: Date,
    default: Date.now,
  },
});

const InvoiceSchema = new mongoose.Schema({
  invoiceNo: {
    type: String,
    required: true,
    trim: true,
  },
  title: {
    type: String,
    required: true,
    trim: true,
  },
  amount: {
    type: Number,
    required: true,
    min: 0,
  },
  dueDate: {
    type: Date,
    required: true,
  },
  status: {
    type: String,
    required: true,
    enum: ['Paid', 'Unpaid', 'Partially_Paid', 'Overdue'],
    default: 'Unpaid',
  },
  paidAmount: {
    type: Number,
    default: 0,
    min: 0,
  },
  payments: {
    type: [PaymentSchema],
    default: [],
  },
});

const FeeLedgerSchema = new mongoose.Schema(
  {
    madrasaId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Madrasa',
      required: true,
    },
    studentId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Student',
      required: true,
    },
    academicYear: {
      type: String,
      required: true,
      validate: {
        validator: (v) => /^\d{4}-\d{4}$/.test(v),
        message: (props) => `${props.value} is not a valid academic year format (e.g., 2026-2027).`
      },
    },
    invoices: {
      type: [InvoiceSchema],
      default: [],
    },
  },
  {
    timestamps: true,
  }
);

// Compound Unique Index: Exactly one ledger bucket per student per academic year
FeeLedgerSchema.index({ studentId: 1, academicYear: 1 }, { unique: true });

// Optimize lookups by tenant context
FeeLedgerSchema.index({ madrasaId: 1 });

// Optimize query performance for individual invoices
FeeLedgerSchema.index({ madrasaId: 1, 'invoices.invoiceNo': 1 }, { unique: true, sparse: true });

module.exports = mongoose.model('FeeLedger', FeeLedgerSchema);
