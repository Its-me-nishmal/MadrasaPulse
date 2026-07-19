const { z } = require('zod');
const DeviceToken = require('../models/DeviceToken');

const registerTokenSchema = z.object({
  token: z.string().trim().min(5),
  platform: z.enum(['android', 'ios']),
});

const sendAlertSchema = z.object({
  recipientPhone: z.string().trim().min(7),
  messageType: z.enum(['attendance', 'fees', 'exam']),
  message: z.string().trim().min(1),
});

/**
 * Register mobile FCM device token for push notifications
 */
const registerDeviceToken = async (req, res, next) => {
  try {
    const { token, platform } = registerTokenSchema.parse(req.body);
    const userId = req.user.userId;

    // Upsert token registration: updates userId if token already registered, or creates new
    const deviceToken = await DeviceToken.findOneAndUpdate(
      { token },
      { userId, platform },
      { new: true, upsert: true }
    );

    res.status(200).json({
      success: true,
      message: 'Mobile push device token successfully registered.',
      data: deviceToken,
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
 * Trigger SMS (Twilio) & WhatsApp mock dispatches
 */
const sendAlert = async (req, res, next) => {
  try {
    const { recipientPhone, messageType, message } = sendAlertSchema.parse(req.body);
    const madrasaId = req.user.madrasaId;

    // Simulating external Twilio and WhatsApp Business API integrations
    console.log(`\n--- MOCK DISPATCH TRIGGERED ---`);
    console.log(`Madrasa Tenant Context ID: ${madrasaId}`);
    console.log(`Recipient Phone: ${recipientPhone}`);
    console.log(`Alert Category: ${messageType.toUpperCase()}`);
    console.log(`Message Content: "${message}"`);
    console.log(`Status: DISPATCHED SUCCESSFULLY VIA TWILIO/WHATSAPP MOCK INTEGRATOR\n`);

    res.status(200).json({
      success: true,
      message: `Alert successfully dispatched.`,
      dispatchLog: {
        provider: 'Twilio & WhatsApp Business API Mocked',
        recipient: recipientPhone,
        type: messageType,
        timestamp: new Date().toISOString(),
      },
    });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({
        success: false,
        error: {
          code: 'VALIDATION_FAILED',
          message: 'Invalid alert request payload.',
          details: error.errors.map(err => ({ field: err.path.join('.'), issue: err.message })),
        },
      });
    }
    next(error);
  }
};

module.exports = {
  registerDeviceToken,
  sendAlert,
};
