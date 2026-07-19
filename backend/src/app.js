const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const mongoose = require('mongoose');
const connectDB = require('./config/db');
const rateLimit = require('express-rate-limit');
const logger = require('./logger');
const { swaggerServe, swaggerSetup } = require('./swagger');
const { initSentry, requestHandler, errorHandler } = require('./sentry');

const app = express();

initSentry(app);

// Security headers
app.use(helmet());

// Serverless DB Connection Middleware
app.use(async (req, res, next) => {
  if (mongoose.connection.readyState === 0) {
    try {
      await connectDB();
    } catch (err) {
      return next(err);
    }
  }
  next();
});

// CORS configuration
const allowedOrigins = process.env.CORS_ORIGIN
  ? process.env.CORS_ORIGIN.split(',').map(s => s.trim())
  : ['http://localhost:3000', 'http://localhost:5000'];
app.use(cors({
  origin: (origin, callback) => {
    if (!origin || allowedOrigins.includes(origin)) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
  methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization'],
  credentials: true,
}));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(requestHandler());

// Request logging
app.use((req, res, next) => {
  logger.info(`${req.method} ${req.url}`, {
    ip: req.ip,
    userAgent: req.get('User-Agent')
  });
  next();
});

// Rate limiting
const limiter = rateLimit({
  windowMs: parseInt(process.env.RATE_LIMIT_WINDOW_MS) || 15 * 60 * 1000,
  max: parseInt(process.env.RATE_LIMIT_MAX) || 100,
  message: {
    success: false,
    error: {
      code: 'RATE_LIMIT_EXCEEDED',
      message: 'Too many requests, please try again later.'
    }
  },
  standardHeaders: true,
  legacyHeaders: false,
});
app.use('/api/', limiter);

// Stricter rate limiter for auth endpoints (brute force protection)
const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 10,
  message: {
    success: false,
    error: {
      code: 'AUTH_RATE_LIMIT_EXCEEDED',
      message: 'Too many login attempts. Please try again after 15 minutes.'
    }
  },
  standardHeaders: true,
  legacyHeaders: false,
});
app.use('/api/v1/auth/login', authLimiter);

// Health Check Route
app.get('/api/v1/health', (req, res) => {
  res.status(200).json({
    success: true,
    message: 'MadrasaPulse API Server is running smoothly',
    timestamp: new Date().toISOString()
  });
});

// Swagger API Documentation
app.use('/api-docs', swaggerServe, swaggerSetup);

// Auth Routes registration
const authRoutes = require('./routes/authRoutes');
app.use('/api/v1/auth', authRoutes);

// Student Routes registration
const studentRoutes = require('./routes/studentRoutes');
app.use('/api/v1/students', studentRoutes);

// Teacher Routes registration
const teacherRoutes = require('./routes/teacherRoutes');
app.use('/api/v1/teachers', teacherRoutes);

// Attendance Routes registration
const attendanceRoutes = require('./routes/attendanceRoutes');
app.use('/api/v1/attendance', attendanceRoutes);

// Fees Routes registration
const feeRoutes = require('./routes/feeRoutes');
app.use('/api/v1/fees', feeRoutes);

// Exams Routes registration
const examRoutes = require('./routes/examRoutes');
app.use('/api/v1/exams', examRoutes);

// Communication Routes registration
const communicationRoutes = require('./routes/communicationRoutes');
app.use('/api/v1/communication', communicationRoutes);

// Global Error Handler
app.use(errorHandler());

app.use((err, req, res, _next) => {
  logger.error(err.stack);
  res.status(err.status || 500).json({
    success: false,
    error: {
      code: err.code || 'INTERNAL_SERVER_ERROR',
      message: err.message || 'An unexpected error occurred on the server.'
    }
  });
});

module.exports = app;
