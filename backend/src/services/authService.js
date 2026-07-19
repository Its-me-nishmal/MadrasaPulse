const User = require('../models/User');
const { generateAccessToken, generateRefreshToken, verifyToken } = require('../utils/token');

/**
 * Register a new user and return JWT tokens
 * @param {Object} userData - User registration payload with madrasaId, username, password, role, linkedEntityId
 * @returns {Promise<{user: Object, accessToken: String, refreshToken: String}>}
 */
const registerUser = async (userData) => {
  const existingUser = await User.findOne({
    madrasaId: userData.madrasaId,
    username: userData.username.toLowerCase()
  });
  if (existingUser) {
    const error = new Error('A user with this username is already registered at this madrasa.');
    error.statusCode = 409;
    error.code = 'USER_EXISTS';
    throw error;
  }
  const newUser = new User({
    madrasaId: userData.madrasaId,
    username: userData.username,
    passwordHash: userData.password,
    role: userData.role,
    linkedEntityId: userData.linkedEntityId,
  });
  await newUser.save();
  const accessToken = generateAccessToken(newUser);
  const refreshToken = generateRefreshToken(newUser);
  return {
    user: {
      id: newUser._id,
      madrasaId: newUser.madrasaId,
      username: newUser.username,
      role: newUser.role,
      linkedEntityId: newUser.linkedEntityId,
      isActive: newUser.isActive,
    },
    accessToken,
    refreshToken,
  };
};

/**
 * Authenticate a user with credentials and return JWT tokens
 * @param {Object} credentials - Login payload with madrasaId, username, password
 * @returns {Promise<{user: Object, accessToken: String, refreshToken: String}>}
 */
const loginUser = async (credentials) => {
  const user = await User.findOne({
    madrasaId: credentials.madrasaId,
    username: credentials.username,
  });
  if (!user || !(await user.comparePassword(credentials.password))) {
    const error = new Error('Incorrect username, password, or madrasa context.');
    error.statusCode = 401;
    error.code = 'INVALID_CREDENTIALS';
    throw error;
  }
  if (!user.isActive) {
    const error = new Error('Your user profile has been suspended or deactivated.');
    error.statusCode = 403;
    error.code = 'USER_SUSPENDED';
    throw error;
  }
  const accessToken = generateAccessToken(user);
  const refreshToken = generateRefreshToken(user);
  return {
    user: {
      id: user._id,
      madrasaId: user.madrasaId,
      username: user.username,
      role: user.role,
      linkedEntityId: user.linkedEntityId,
    },
    accessToken,
    refreshToken,
  };
};

/**
 * Verify a refresh token and issue a new access token
 * @param {String} refreshTokenStr - The refresh JWT string
 * @returns {Promise<{accessToken: String}>}
 */
const refreshUserToken = async (refreshTokenStr) => {
  const decoded = verifyToken(refreshTokenStr, 'refresh');
  const user = await User.findById(decoded.userId);
  if (!user) {
    const error = new Error('Associated session user profile not found.');
    error.statusCode = 404;
    error.code = 'USER_NOT_FOUND';
    throw error;
  }
  if (!user.isActive) {
    const error = new Error('User profile has been suspended.');
    error.statusCode = 403;
    error.code = 'USER_SUSPENDED';
    throw error;
  }
  return { accessToken: generateAccessToken(user) };
};

module.exports = { registerUser, loginUser, refreshUserToken };
