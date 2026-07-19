const DeviceToken = require('../models/DeviceToken');

/**
 * Register or update a push notification device token for a user
 * @param {String} userId - The user's MongoDB ObjectId
 * @param {String} token - The device push token
 * @param {String} platform - The device platform (e.g. ios, android)
 * @returns {Promise<Object>} The device token document
 */
const registerDeviceToken = async (userId, token, platform) => {
  const deviceToken = await DeviceToken.findOneAndUpdate(
    { token },
    { userId, platform },
    { new: true, upsert: true }
  );
  return deviceToken;
};

/**
 * Dispatch an SMS or WhatsApp alert message (mocked implementation)
 * @param {String} madrasaId - The madrasa tenant ID
 * @param {Object} data - Alert payload with recipientPhone, messageType, message
 * @returns {Promise<Object>} Dispatch log with provider info and timestamp
 */
const sendAlert = async (madrasaId, data) => {
  console.info('\n--- MOCK DISPATCH TRIGGERED ---');
  console.info(`Madrasa Tenant Context ID: ${madrasaId}`);
  console.info(`Recipient Phone: ${data.recipientPhone}`);
  console.info(`Alert Category: ${data.messageType.toUpperCase()}`);
  console.info(`Message Content: "${data.message}"`);
  console.info('Status: DISPATCHED SUCCESSFULLY VIA TWILIO/WHATSAPP MOCK INTEGRATOR\n');
  return {
    provider: 'Twilio & WhatsApp Business API Mocked',
    recipient: data.recipientPhone,
    type: data.messageType,
    timestamp: new Date().toISOString(),
  };
};

module.exports = { registerDeviceToken, sendAlert };
