const express = require('express');
const {
  createInvoice,
  getStudentLedger,
  recordPayment,
} = require('../controllers/feeController');
const { requireAuth, requirePermission } = require('../middleware/auth');

const router = express.Router();

// Protect all finance/fee endpoints
router.use(requireAuth);

/**
 * @swagger
 * components:
 *   schemas:
 *     ErrorResponse:
 *       type: object
 *       properties:
 *         success:
 *           type: boolean
 *           example: false
 *         message:
 *           type: string
 *           example: "Error message"
 *     ValidationError:
 *       type: object
 *       properties:
 *         success:
 *           type: boolean
 *           example: false
 *         message:
 *           type: string
 *           example: "Validation failed"
 *         errors:
 *           type: array
 *           items:
 *             type: object
 *             properties:
 *               field:
 *                 type: string
 *               message:
 *                 type: string
 */

/**
 * @swagger
 * /api/v1/fees/invoice:
 *   post:
 *     tags: [Fees]
 *     summary: Create a new fee invoice and post it to the student's ledger
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [studentId, academicYear, invoiceNo, title, amount, dueDate]
 *             properties:
 *               studentId:
 *                 type: string
 *                 description: MongoDB ObjectId of the student
 *               academicYear:
 *                 type: string
 *                 pattern: '^\d{4}-\d{4}$'
 *                 description: Academic year in YYYY-YYYY format
 *               invoiceNo:
 *                 type: string
 *               title:
 *                 type: string
 *               amount:
 *                 type: number
 *                 minimum: 0
 *               dueDate:
 *                 type: string
 *                 format: date
 *     responses:
 *       201:
 *         description: Invoice created successfully
 *       400:
 *         description: Validation error
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ValidationError'
 */

router.post('/invoice', requirePermission('fees:write'), createInvoice);
/**
 * @swagger
 * /api/v1/fees/ledger/{studentId}:
 *   get:
 *     tags: [Fees]
 *     summary: Retrieve the fee ledger for a student in a given academic year
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: studentId
 *         required: true
 *         schema:
 *           type: string
 *         description: MongoDB ObjectId of the student
 *       - in: query
 *         name: academicYear
 *         required: true
 *         schema:
 *           type: string
 *           pattern: '^\d{4}-\d{4}$'
 *         description: Academic year in YYYY-YYYY format
 *     responses:
 *       200:
 *         description: Student fee ledger data
 *       400:
 *         description: Missing or invalid academicYear query parameter
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ValidationError'
 */

router.get('/ledger/:studentId', requirePermission('fees:read'), getStudentLedger);
/**
 * @swagger
 * /api/v1/fees/pay:
 *   post:
 *     tags: [Fees]
 *     summary: Record a payment against an existing invoice
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [invoiceNo, amountPaid, paymentMethod, transactionId]
 *             properties:
 *               invoiceNo:
 *                 type: string
 *               amountPaid:
 *                 type: number
 *                 minimum: 0
 *               paymentMethod:
 *                 type: string
 *                 enum: [Stripe, Razorpay, Cash, BankTransfer]
 *               transactionId:
 *                 type: string
 *     responses:
 *       200:
 *         description: Payment recorded successfully
 *       400:
 *         description: Validation error
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ValidationError'
 *       404:
 *         description: Invoice not found
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ErrorResponse'
 */

router.post('/pay', requirePermission('fees:write'), recordPayment);

module.exports = router;
