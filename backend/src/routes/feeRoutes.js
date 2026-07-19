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

router.post('/invoice', requirePermission('fees:write'), createInvoice);
router.get('/ledger/:studentId', requirePermission('fees:read'), getStudentLedger);
router.post('/pay', requirePermission('fees:write'), recordPayment);

module.exports = router;
