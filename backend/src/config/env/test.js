module.exports = {
  port: process.env.PORT || 5001,
  mongoUri: process.env.MONGODB_URI || 'mongodb://localhost:27017/madrasapulse_test',
  jwtSecret: 'test-jwt-secret',
  jwtRefreshSecret: 'test-jwt-refresh-secret',
  corsOrigin: '*',
  rateLimit: {
    windowMs: 60 * 1000,
    max: 1000,
  },
  logLevel: 'silent',
};
