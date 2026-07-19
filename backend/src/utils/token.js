const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET || 'supersecretactivationkeyherefordevelopment';
const JWT_REFRESH_SECRET = process.env.JWT_REFRESH_SECRET || 'anotherrefreshsecretactivationkeyherefordevelopment';

/**
 * Generates a short-lived access JWT token
 * @param {Object} user 
 * @returns {String} access token
 */
const generateAccessToken = (user) => {
  const payload = {
    userId: user._id,
    madrasaId: user.madrasaId,
    role: user.role,
    // Add default permissions based on role if needed (mapping from specs)
    permissions: getRolePermissions(user.role)
  };

  return jwt.sign(payload, JWT_SECRET, { expiresIn: '15m' });
};

/**
 * Generates a long-lived refresh JWT token
 * @param {Object} user 
 * @returns {String} refresh token
 */
const generateRefreshToken = (user) => {
  const payload = {
    userId: user._id,
  };

  return jwt.sign(payload, JWT_REFRESH_SECRET, { expiresIn: '30d' });
};

/**
 * Verifies a JWT token signature
 * @param {String} token 
 * @param {String} secret 
 * @returns {Object} decoded payload
 */
const verifyToken = (token, secretType = 'access') => {
  const secret = secretType === 'refresh' ? JWT_REFRESH_SECRET : JWT_SECRET;
  return jwt.verify(token, secret);
};

// Helper utility to get default permissions by role based on spec doc
const getRolePermissions = (role) => {
  const permissionMap = {
    SuperAdmin: ['*'],
    MadrasaAdmin: [
      'students:read', 'students:write', 'students:promote', 'students:delete',
      'teachers:read', 'teachers:write', 'teachers:delete',
      'attendance:read', 'attendance:write',
      'fees:read', 'fees:write', 'fees:reconcile',
      'exams:read', 'exams:write', 'exams:publish',
      'settings:read', 'settings:write'
    ],
    Teacher: [
      'students:read',
      'attendance:read', 'attendance:write',
      'exams:read', 'exams:write'
    ],
    Parent: [
      'students:read',
      'attendance:read',
      'fees:read', 'fees:write',
      'exams:read'
    ],
    Student: [
      'students:read',
      'attendance:read',
      'exams:read'
    ]
  };

  return permissionMap[role] || [];
};

module.exports = {
  generateAccessToken,
  generateRefreshToken,
  verifyToken
};
