const express = require('express');
const {
  registerDeviceToken,
  sendAlert,
} = require('../controllers/communicationController');
const { requireAuth, requirePermission } = require('../middleware/auth');

const router = express.Router();

// Apply auth middleware to protect all communication endpoints
router.use(requireAuth);

router.post('/device-token', registerDeviceToken);
router.post('/send-alert', requirePermission('settings:write'), sendAlert);

module.exports = router;
