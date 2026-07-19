const express = require('express');
const {
  registerDeviceToken,
  sendAlert,
} = require('../controllers/communicationController');
const { requireAuth, requirePermission } = require('../middleware/auth');

const router = express.Router();

// Apply auth middleware to protect all communication endpoints
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
 * /api/v1/communication/device-token:
 *   post:
 *     tags: [Communication]
 *     summary: Register a mobile device push notification token for a user
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [token, platform]
 *             properties:
 *               token:
 *                 type: string
 *                 description: Push notification device token
 *               platform:
 *                 type: string
 *                 enum: [android, ios]
 *     responses:
 *       200:
 *         description: Device token registered successfully
 *       400:
 *         description: Validation error
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ValidationError'
 */

router.post('/device-token', registerDeviceToken);
/**
 * @swagger
 * /api/v1/communication/send-alert:
 *   post:
 *     tags: [Communication]
 *     summary: Dispatch an SMS or WhatsApp alert to a recipient
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [recipientPhone, messageType, message]
 *             properties:
 *               recipientPhone:
 *                 type: string
 *                 description: Recipient phone number
 *               messageType:
 *                 type: string
 *                 enum: [attendance, fees, exam]
 *               message:
 *                 type: string
 *     responses:
 *       200:
 *         description: Alert dispatched successfully
 *       400:
 *         description: Validation error
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ValidationError'
 */

router.post('/send-alert', requirePermission('settings:write'), sendAlert);

module.exports = router;
