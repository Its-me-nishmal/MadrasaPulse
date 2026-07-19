const { z } = require('zod');

const asyncHandler = (fn) => {
  return (req, res, next) => {
    Promise.resolve(fn(req, res, next)).catch(next);
  };
};

const handleValidationError = (error, res) => {
  if (error instanceof z.ZodError) {
    res.status(400).json({
      success: false,
      error: {
        code: 'VALIDATION_FAILED',
        message: 'Invalid input payload parameters.',
        details: error.errors.map(err => ({
          field: err.path.join('.'),
          issue: err.message
        }))
      }
    });
    return true;
  }
  return false;
};

const handleServiceError = (error, res) => {
  if (error.statusCode) {
    res.status(error.statusCode).json({
      success: false,
      error: {
        code: error.code || 'SERVICE_ERROR',
        message: error.message
      }
    });
    return true;
  }
  return false;
};

const catchError = (error, res, next) => {
  if (handleValidationError(error, res)) return;
  if (handleServiceError(error, res)) return;
  next(error);
};

module.exports = { asyncHandler, catchError, handleValidationError, handleServiceError };
