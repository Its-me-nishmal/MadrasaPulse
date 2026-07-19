module.exports = {
  port: process.env.PORT || 5000,
  mongoUri: process.env.MONGODB_URI || 'mongodb://localhost:27017/madrasapulse',
  jwtSecret: process.env.JWT_SECRET || 'dev-jwt-secret',
  jwtRefreshSecret: process.env.JWT_REFRESH_SECRET || 'dev-jwt-refresh-secret',
  corsOrigin: process.env.CORS_ORIGIN || 'http://localhost:3000,http://localhost:5000',
  rateLimit: {
    windowMs: parseInt(process.env.RATE_LIMIT_WINDOW_MS) || 15 * 60 * 1000,
    max: parseInt(process.env.RATE_LIMIT_MAX) || 100,
  },
  logLevel: process.env.LOG_LEVEL || 'debug',
};
