const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const mockUserInstance = {
  _id: '60d5ec49c6d1a21e483e5891',
  madrasaId: '60d5ec49c6d1a21e483e5896',
  username: 'adminuser',
  role: 'MadrasaAdmin',
  linkedEntityId: undefined,
  isActive: true,
  save: jest.fn().mockResolvedValue(),
  comparePassword: jest.fn(),
};

jest.mock('../../src/models/User', () => {
  const mockModel = function (data) {
    Object.assign(this, { ...mockUserInstance, ...data });
    this._id = mockUserInstance._id;
    this.save = jest.fn().mockResolvedValue();
    this.comparePassword = jest.fn();
  };
  mockModel.findOne = jest.fn();
  mockModel.findById = jest.fn();
  mockModel.prototype.save = jest.fn().mockResolvedValue();
  mockModel.prototype.comparePassword = jest.fn();
  return mockModel;
});

jest.mock('../../src/utils/token', () => ({
  generateAccessToken: jest.fn(() => 'mock-access-token'),
  generateRefreshToken: jest.fn(() => 'mock-refresh-token'),
  verifyToken: jest.fn(),
}));

const User = require('../../src/models/User');
const { generateAccessToken, generateRefreshToken, verifyToken } = require('../../src/utils/token');
const { registerUser, loginUser, refreshUserToken } = require('../../src/services/authService');

describe('Auth Service', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('registerUser', () => {
    const validUserData = {
      madrasaId: '60d5ec49c6d1a21e483e5896',
      username: 'newadmin',
      password: 'securepass123',
      role: 'MadrasaAdmin',
    };

    it('creates a new user and returns user data with tokens', async () => {
      User.findOne.mockResolvedValue(null);

      const result = await registerUser(validUserData);

      expect(User.findOne).toHaveBeenCalledWith({
        madrasaId: validUserData.madrasaId,
        username: validUserData.username,
      });
      expect(result.user).toBeDefined();
      expect(result.user.username).toBe(validUserData.username);
      expect(result.user.role).toBe(validUserData.role);
      expect(result.accessToken).toBe('mock-access-token');
      expect(result.refreshToken).toBe('mock-refresh-token');
      expect(generateAccessToken).toHaveBeenCalled();
      expect(generateRefreshToken).toHaveBeenCalled();
    });

    it('rejects duplicate username within the same madrasa', async () => {
      User.findOne.mockResolvedValue({ _id: 'existing-id', username: validUserData.username });

      await expect(registerUser(validUserData)).rejects.toThrow(
        'A user with this username is already registered at this madrasa.'
      );
      await expect(registerUser(validUserData)).rejects.toMatchObject({
        statusCode: 409,
        code: 'USER_EXISTS',
      });
    });

    it('searches by lowercase username', async () => {
      User.findOne.mockResolvedValue(null);

      await registerUser({ ...validUserData, username: 'AdminUser' });

      expect(User.findOne).toHaveBeenCalledWith(
        expect.objectContaining({ username: 'adminuser' })
      );
    });
  });

  describe('loginUser', () => {
    const credentials = {
      madrasaId: '60d5ec49c6d1a21e483e5896',
      username: 'adminuser',
      password: 'securepass123',
    };

    it('returns tokens for valid credentials', async () => {
      const mockUser = {
        ...mockUserInstance,
        comparePassword: jest.fn().mockResolvedValue(true),
      };
      User.findOne.mockResolvedValue(mockUser);

      const result = await loginUser(credentials);

      expect(User.findOne).toHaveBeenCalledWith({
        madrasaId: credentials.madrasaId,
        username: credentials.username,
      });
      expect(mockUser.comparePassword).toHaveBeenCalledWith(credentials.password);
      expect(result.accessToken).toBe('mock-access-token');
      expect(result.refreshToken).toBe('mock-refresh-token');
    });

    it('rejects invalid credentials when user not found', async () => {
      User.findOne.mockResolvedValue(null);

      await expect(loginUser(credentials)).rejects.toThrow(
        'Incorrect username, password, or madrasa context.'
      );
      await expect(loginUser(credentials)).rejects.toMatchObject({
        statusCode: 401,
        code: 'INVALID_CREDENTIALS',
      });
    });

    it('rejects invalid credentials when password does not match', async () => {
      const mockUser = {
        ...mockUserInstance,
        comparePassword: jest.fn().mockResolvedValue(false),
      };
      User.findOne.mockResolvedValue(mockUser);

      await expect(loginUser(credentials)).rejects.toThrow(
        'Incorrect username, password, or madrasa context.'
      );
      await expect(loginUser(credentials)).rejects.toMatchObject({
        statusCode: 401,
        code: 'INVALID_CREDENTIALS',
      });
    });

    it('rejects suspended users', async () => {
      const mockUser = {
        ...mockUserInstance,
        isActive: false,
        comparePassword: jest.fn().mockResolvedValue(true),
      };
      User.findOne.mockResolvedValue(mockUser);

      await expect(loginUser(credentials)).rejects.toThrow(
        'Your user profile has been suspended or deactivated.'
      );
      await expect(loginUser(credentials)).rejects.toMatchObject({
        statusCode: 403,
        code: 'USER_SUSPENDED',
      });
    });
  });

  describe('refreshUserToken', () => {
    it('returns a new access token for a valid refresh token', async () => {
      verifyToken.mockReturnValue({ userId: mockUserInstance._id });
      User.findById.mockResolvedValue({ ...mockUserInstance, isActive: true });

      const result = await refreshUserToken('valid-refresh-token');

      expect(verifyToken).toHaveBeenCalledWith('valid-refresh-token', 'refresh');
      expect(User.findById).toHaveBeenCalledWith(mockUserInstance._id);
      expect(result.accessToken).toBe('mock-access-token');
    });

    it('throws USER_NOT_FOUND when user does not exist', async () => {
      verifyToken.mockReturnValue({ userId: 'nonexistent-id' });
      User.findById.mockResolvedValue(null);

      await expect(refreshUserToken('some-token')).rejects.toMatchObject({
        statusCode: 404,
        code: 'USER_NOT_FOUND',
      });
    });

    it('throws USER_SUSPENDED when user is inactive', async () => {
      verifyToken.mockReturnValue({ userId: mockUserInstance._id });
      User.findById.mockResolvedValue({ ...mockUserInstance, isActive: false });

      await expect(refreshUserToken('some-token')).rejects.toMatchObject({
        statusCode: 403,
        code: 'USER_SUSPENDED',
      });
    });
  });
});
