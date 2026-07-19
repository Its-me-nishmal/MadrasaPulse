const { z } = require('zod');
const { registerSchema, loginSchema, refreshSchema } = require('../validators/authValidator');
const { registerUser, loginUser, refreshUserToken } = require('../services/authService');
const { catchError } = require('../utils/errorHandler');

/**
 * Register a new user account
 * @param {import('express').Request} req - Express request object with validated body
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const register = async (req, res, next) => {
  try {
    const validatedBody = registerSchema.parse(req.body);
    const result = await registerUser(validatedBody);
    res.status(201).json({ success: true, data: result });
  } catch (error) {
    catchError(error, res, next);
  }
};

/**
 * Authenticate a user and return JWT tokens
 * @param {import('express').Request} req - Express request object with validated credentials
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const login = async (req, res, next) => {
  try {
    const validatedBody = loginSchema.parse(req.body);
    const result = await loginUser(validatedBody);
    res.status(200).json({ success: true, data: result });
  } catch (error) {
    catchError(error, res, next);
  }
};

/**
 * Issue a new access token using a valid refresh token
 * @param {import('express').Request} req - Express request object with refresh token
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} _next - Express next middleware function
 * @returns {Promise<void>}
 */
const refresh = async (req, res, _next) => {
  try {
    const validatedBody = refreshSchema.parse(req.body);
    const result = await refreshUserToken(validatedBody.refreshToken);
    res.status(200).json({ success: true, data: result });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({ success: false, error: { code: 'VALIDATION_FAILED', message: 'Missing refresh token parameter.' } });
    }
    if (error.statusCode) {
      return res.status(error.statusCode).json({ success: false, error: { code: error.code, message: error.message } });
    }
    return res.status(401).json({ success: false, error: { code: 'INVALID_REFRESH_TOKEN', message: 'Refresh token has expired or is invalid.' } });
  }
};

module.exports = { register, login, refresh };
