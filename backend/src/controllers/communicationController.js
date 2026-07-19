const { registerTokenSchema, sendAlertSchema } = require('../validators/communicationValidator');
const communicationService = require('../services/communicationService');
const { catchError } = require('../utils/errorHandler');

/**
 * Register a mobile device push notification token for a user
 * @param {import('express').Request} req - Express request object with token and platform
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const registerDeviceToken = async (req, res, next) => {
  try {
    const { token, platform } = registerTokenSchema.parse(req.body);
    const userId = req.user.userId;
    const deviceToken = await communicationService.registerDeviceToken(userId, token, platform);
    res.status(200).json({ success: true, message: 'Mobile push device token successfully registered.', data: deviceToken });
  } catch (error) {
    catchError(error, res, next);
  }
};

/**
 * Dispatch an SMS or WhatsApp alert to a recipient
 * @param {import('express').Request} req - Express request object with validated alert data
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const sendAlert = async (req, res, next) => {
  try {
    const validatedBody = sendAlertSchema.parse(req.body);
    const madrasaId = req.user.madrasaId;
    const dispatchLog = await communicationService.sendAlert(madrasaId, validatedBody);
    res.status(200).json({ success: true, message: 'Alert successfully dispatched.', dispatchLog });
  } catch (error) {
    catchError(error, res, next);
  }
};

module.exports = { registerDeviceToken, sendAlert };
