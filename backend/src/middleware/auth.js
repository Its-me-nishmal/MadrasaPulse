const { verifyToken } = require('../utils/token');

/**
 * Protects routes requiring valid JWT authorization
 * @param {import('express').Request} req - Express request object
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const requireAuth = async (req, res, next) => {
  const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({
      success: false,
      error: {
        code: 'UNAUTHORIZED',
        message: 'Access denied. Authorization token missing or malformed.'
      }
    });
  }

  const token = authHeader.split(' ')[1];

  try {
    const decoded = verifyToken(token, 'access');
    req.user = decoded; // Attach user claims payload (userId, madrasaId, role, permissions)
    next();
  } catch (error) {
    let message = 'Access denied. Invalid signature token.';
    let code = 'INVALID_TOKEN';

    if (error.name === 'TokenExpiredError') {
      message = 'Access token has expired.';
      code = 'TOKEN_EXPIRED';
    }

    return res.status(401).json({
      success: false,
      error: {
        code,
        message
      }
    });
  }
};

/**
 * Validates that the authenticated user has the required permission scope
 * @param {String} requiredPermission - The permission string to check (e.g. 'students:write')
 * @returns {import('express').RequestHandler} Middleware function that checks permissions
 */
const requirePermission = (requiredPermission) => {
  return (req, res, next) => {
    if (!req.user || !req.user.permissions) {
      return res.status(403).json({
        success: false,
        error: {
          code: 'FORBIDDEN',
          message: 'Access denied. Missing permissions configuration.'
        }
      });
    }

    const { permissions } = req.user;

    // SuperAdmin wildcard bypasses permission checks
    if (permissions.includes('*')) {
      return next();
    }

    if (!permissions.includes(requiredPermission)) {
      return res.status(403).json({
        success: false,
        error: {
          code: 'FORBIDDEN',
          message: `Access denied. Action requires permission scope: ${requiredPermission}`
        }
      });
    }

    next();
  };
};

module.exports = {
  requireAuth,
  requirePermission
};
