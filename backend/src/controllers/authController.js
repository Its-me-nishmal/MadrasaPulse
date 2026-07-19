const { z } = require('zod');
const User = require('../models/User');
const {
  generateAccessToken,
  generateRefreshToken,
  verifyToken
} = require('../utils/token');

// Payload validation schemas using Zod
const registerSchema = z.object({
  madrasaId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Madrasa ID format'),
  username: z.string().min(3, 'Username must be at least 3 characters long'),
  password: z.string().min(6, 'Password must be at least 6 characters long'),
  role: z.enum(['SuperAdmin', 'MadrasaAdmin', 'Teacher', 'Parent', 'Student']),
  linkedEntityId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Entity ID format').optional()
});

const loginSchema = z.object({
  madrasaId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Madrasa ID format'),
  username: z.string().trim().toLowerCase(),
  password: z.string()
});

const refreshSchema = z.object({
  refreshToken: z.string()
});

/**
 * Handle new user registration
 */
const register = async (req, res, next) => {
  try {
    const validatedBody = registerSchema.parse(req.body);

    const existingUser = await User.findOne({
      madrasaId: validatedBody.madrasaId,
      username: validatedBody.username.toLowerCase()
    });

    if (existingUser) {
      return res.status(409).json({
        success: false,
        error: {
          code: 'USER_EXISTS',
          message: 'A user with this username is already registered at this madrasa.'
        }
      });
    }

    const newUser = new User({
      madrasaId: validatedBody.madrasaId,
      username: validatedBody.username,
      passwordHash: validatedBody.password, // Hook hashes this on save
      role: validatedBody.role,
      linkedEntityId: validatedBody.linkedEntityId
    });

    await newUser.save();

    // Generate session JWT tokens
    const accessToken = generateAccessToken(newUser);
    const refreshToken = generateRefreshToken(newUser);

    res.status(201).json({
      success: true,
      data: {
        user: {
          id: newUser._id,
          madrasaId: newUser.madrasaId,
          username: newUser.username,
          role: newUser.role,
          linkedEntityId: newUser.linkedEntityId,
          isActive: newUser.isActive
        },
        accessToken,
        refreshToken
      }
    });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({
        success: false,
        error: {
          code: 'VALIDATION_FAILED',
          message: 'Invalid input payload parameters.',
          details: error.errors.map(err => ({ field: err.path.join('.'), issue: err.message }))
        }
      });
    }
    next(error);
  }
};

/**
 * User authentication & session generation
 */
const login = async (req, res, next) => {
  try {
    const validatedBody = loginSchema.parse(req.body);

    const user = await User.findOne({
      madrasaId: validatedBody.madrasaId,
      username: validatedBody.username
    });

    if (!user || !(await user.comparePassword(validatedBody.password))) {
      return res.status(401).json({
        success: false,
        error: {
          code: 'INVALID_CREDENTIALS',
          message: 'Incorrect username, password, or madrasa context.'
        }
      });
    }

    if (!user.isActive) {
      return res.status(403).json({
        success: false,
        error: {
          code: 'USER_SUSPENDED',
          message: 'Your user profile has been suspended or deactivated.'
        }
      });
    }

    const accessToken = generateAccessToken(user);
    const refreshToken = generateRefreshToken(user);

    res.status(200).json({
      success: true,
      data: {
        user: {
          id: user._id,
          madrasaId: user.madrasaId,
          username: user.username,
          role: user.role,
          linkedEntityId: user.linkedEntityId
        },
        accessToken,
        refreshToken
      }
    });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({
        success: false,
        error: {
          code: 'VALIDATION_FAILED',
          message: 'Invalid input payload parameters.',
          details: error.errors.map(err => ({ field: err.path.join('.'), issue: err.message }))
        }
      });
    }
    next(error);
  }
};

/**
 * Token rotation (issues new access JWT)
 */
const refresh = async (req, res, next) => {
  try {
    const validatedBody = refreshSchema.parse(req.body);
    const decoded = verifyToken(validatedBody.refreshToken, 'refresh');

    const user = await User.findById(decoded.userId);

    if (!user) {
      return res.status(404).json({
        success: false,
        error: {
          code: 'USER_NOT_FOUND',
          message: 'Associated session user profile not found.'
        }
      });
    }

    if (!user.isActive) {
      return res.status(403).json({
        success: false,
        error: {
          code: 'USER_SUSPENDED',
          message: 'User profile has been suspended.'
        }
      });
    }

    const accessToken = generateAccessToken(user);

    res.status(200).json({
      success: true,
      data: {
        accessToken
      }
    });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({
        success: false,
        error: {
          code: 'VALIDATION_FAILED',
          message: 'Missing refresh token parameter.'
        }
      });
    }

    return res.status(401).json({
      success: false,
      error: {
        code: 'INVALID_REFRESH_TOKEN',
        message: 'Refresh token has expired or is invalid.'
      }
    });
  }
};

module.exports = {
  register,
  login,
  refresh
};
