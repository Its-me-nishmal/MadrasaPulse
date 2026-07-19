const { z } = require('zod');

const registerTokenSchema = z.object({
  token: z.string().trim().min(5),
  platform: z.enum(['android', 'ios']),
});

const sendAlertSchema = z.object({
  recipientPhone: z.string().trim().min(7),
  messageType: z.enum(['attendance', 'fees', 'exam']),
  message: z.string().trim().min(1),
});

module.exports = { registerTokenSchema, sendAlertSchema };
