const { z } = require('zod');

jest.mock('../../src/validators/authValidator', () => ({
  registerSchema: {
    parse: jest.fn(),
  },
  loginSchema: {
    parse: jest.fn(),
  },
  refreshSchema: {
    parse: jest.fn(),
  },
}));

jest.mock('../../src/services/authService', () => ({
  registerUser: jest.fn(),
  loginUser: jest.fn(),
  refreshUserToken: jest.fn(),
}));

const { registerSchema, loginSchema, refreshSchema } = require('../../src/validators/authValidator');
const { registerUser, loginUser, refreshUserToken } = require('../../src/services/authService');
const { register, login, refresh } = require('../../src/controllers/authController');

describe('Auth Controller', () => {
  let mockReq;
  let mockRes;
  let mockNext;

  const createError = (statusCode, code, message) => {
    const err = new Error(message);
    err.statusCode = statusCode;
    err.code = code;
    return err;
  };

  beforeEach(() => {
    mockReq = {
      body: {},
      user: null,
    };
    mockRes = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn().mockReturnThis(),
    };
    mockNext = jest.fn();
    jest.clearAllMocks();
  });

  describe('register', () => {
    const validPayload = {
      madrasaId: '60d5ec49c6d1a21e483e5896',
      username: 'newadmin',
      password: 'securepass123',
      role: 'MadrasaAdmin',
    };

    const mockServiceResult = {
      user: { id: '60d5ec49c6d1a21e483e5891', username: 'newadmin', role: 'MadrasaAdmin' },
      accessToken: 'mock-access-token',
      refreshToken: 'mock-refresh-token',
    };

    it('returns 201 with user data and tokens for valid input', async () => {
      registerSchema.parse.mockReturnValue(validPayload);
      registerUser.mockResolvedValue(mockServiceResult);

      mockReq.body = validPayload;
      await register(mockReq, mockRes, mockNext);

      expect(registerSchema.parse).toHaveBeenCalledWith(validPayload);
      expect(registerUser).toHaveBeenCalledWith(validPayload);
      expect(mockRes.status).toHaveBeenCalledWith(201);
      expect(mockRes.json).toHaveBeenCalledWith({
        success: true,
        data: mockServiceResult,
      });
    });

    it('returns 400 with VALIDATION_FAILED when zod validation fails', async () => {
      const zodError = new z.ZodError([{ path: ['username'], message: 'Required' }]);
      registerSchema.parse.mockImplementation(() => { throw zodError; });

      mockReq.body = { invalid: 'data' };
      await register(mockReq, mockRes, mockNext);

      expect(mockRes.status).toHaveBeenCalledWith(400);
      expect(mockRes.json).toHaveBeenCalledWith({
        success: false,
        error: {
          code: 'VALIDATION_FAILED',
          message: 'Invalid input payload parameters.',
          details: expect.arrayContaining([
            expect.objectContaining({ field: 'username', issue: 'Required' }),
          ]),
        },
      });
    });

    it('returns 409 when service throws duplicate user error', async () => {
      registerSchema.parse.mockReturnValue(validPayload);
      registerUser.mockRejectedValue(
        createError(409, 'USER_EXISTS', 'A user with this username is already registered at this madrasa.')
      );

      await register(mockReq, mockRes, mockNext);

      expect(mockRes.status).toHaveBeenCalledWith(409);
      expect(mockRes.json).toHaveBeenCalledWith({
        success: false,
        error: {
          code: 'USER_EXISTS',
          message: 'A user with this username is already registered at this madrasa.',
        },
      });
    });

    it('passes unknown errors to next middleware', async () => {
      registerSchema.parse.mockReturnValue(validPayload);
      const unknownError = new Error('Database connection failed');
      registerUser.mockRejectedValue(unknownError);

      await register(mockReq, mockRes, mockNext);

      expect(mockNext).toHaveBeenCalledWith(unknownError);
    });
  });

  describe('login', () => {
    const validCredentials = {
      madrasaId: '60d5ec49c6d1a21e483e5896',
      username: 'adminuser',
      password: 'securepass123',
    };

    const mockLoginResult = {
      user: { id: '60d5ec49c6d1a21e483e5891', username: 'adminuser', role: 'MadrasaAdmin' },
      accessToken: 'mock-access-token',
      refreshToken: 'mock-refresh-token',
    };

    it('returns 200 with tokens for valid credentials', async () => {
      loginSchema.parse.mockReturnValue(validCredentials);
      loginUser.mockResolvedValue(mockLoginResult);

      mockReq.body = validCredentials;
      await login(mockReq, mockRes, mockNext);

      expect(loginSchema.parse).toHaveBeenCalledWith(validCredentials);
      expect(loginUser).toHaveBeenCalledWith(validCredentials);
      expect(mockRes.status).toHaveBeenCalledWith(200);
      expect(mockRes.json).toHaveBeenCalledWith({
        success: true,
        data: mockLoginResult,
      });
    });

    it('returns 400 with VALIDATION_FAILED when zod validation fails', async () => {
      const zodError = new z.ZodError([{ path: ['madrasaId'], message: 'Invalid Madrasa ID format' }]);
      loginSchema.parse.mockImplementation(() => { throw zodError; });

      mockReq.body = { username: 'test', password: 'pass' };
      await login(mockReq, mockRes, mockNext);

      expect(mockRes.status).toHaveBeenCalledWith(400);
      expect(mockRes.json).toHaveBeenCalledWith({
        success: false,
        error: {
          code: 'VALIDATION_FAILED',
          message: 'Invalid input payload parameters.',
          details: expect.arrayContaining([
            expect.objectContaining({ field: 'madrasaId', issue: 'Invalid Madrasa ID format' }),
          ]),
        },
      });
    });

    it('returns 401 for invalid credentials', async () => {
      loginSchema.parse.mockReturnValue(validCredentials);
      loginUser.mockRejectedValue(
        createError(401, 'INVALID_CREDENTIALS', 'Incorrect username, password, or madrasa context.')
      );

      await login(mockReq, mockRes, mockNext);

      expect(mockRes.status).toHaveBeenCalledWith(401);
      expect(mockRes.json).toHaveBeenCalledWith({
        success: false,
        error: {
          code: 'INVALID_CREDENTIALS',
          message: 'Incorrect username, password, or madrasa context.',
        },
      });
    });

    it('returns 403 for suspended users', async () => {
      loginSchema.parse.mockReturnValue(validCredentials);
      loginUser.mockRejectedValue(
        createError(403, 'USER_SUSPENDED', 'Your user profile has been suspended or deactivated.')
      );

      await login(mockReq, mockRes, mockNext);

      expect(mockRes.status).toHaveBeenCalledWith(403);
      expect(mockRes.json).toHaveBeenCalledWith({
        success: false,
        error: {
          code: 'USER_SUSPENDED',
          message: 'Your user profile has been suspended or deactivated.',
        },
      });
    });
  });

  describe('refresh', () => {
    it('returns 200 with new access token for valid refresh token', async () => {
      refreshSchema.parse.mockReturnValue({ refreshToken: 'valid-refresh-token' });
      refreshUserToken.mockResolvedValue({ accessToken: 'new-access-token' });

      mockReq.body = { refreshToken: 'valid-refresh-token' };
      await refresh(mockReq, mockRes, mockNext);

      expect(refreshSchema.parse).toHaveBeenCalledWith({ refreshToken: 'valid-refresh-token' });
      expect(refreshUserToken).toHaveBeenCalledWith('valid-refresh-token');
      expect(mockRes.status).toHaveBeenCalledWith(200);
      expect(mockRes.json).toHaveBeenCalledWith({
        success: true,
        data: { accessToken: 'new-access-token' },
      });
    });

    it('returns 400 when refresh token is missing', async () => {
      const zodError = new z.ZodError([{ path: ['refreshToken'], message: 'Required' }]);
      refreshSchema.parse.mockImplementation(() => { throw zodError; });

      mockReq.body = {};
      await refresh(mockReq, mockRes, mockNext);

      expect(mockRes.status).toHaveBeenCalledWith(400);
      expect(mockRes.json).toHaveBeenCalledWith({
        success: false,
        error: {
          code: 'VALIDATION_FAILED',
          message: 'Missing refresh token parameter.',
        },
      });
    });

    it('returns 401 for expired or invalid refresh token', async () => {
      refreshSchema.parse.mockReturnValue({ refreshToken: 'expired-token' });
      refreshUserToken.mockRejectedValue(
        createError(401, 'INVALID_REFRESH_TOKEN', 'Refresh token has expired or is invalid.')
      );

      await refresh(mockReq, mockRes, mockNext);

      expect(mockRes.status).toHaveBeenCalledWith(401);
    });

    it('returns 404 when user not found from refresh token', async () => {
      refreshSchema.parse.mockReturnValue({ refreshToken: 'some-token' });
      refreshUserToken.mockRejectedValue(
        createError(404, 'USER_NOT_FOUND', 'Associated session user profile not found.')
      );

      await refresh(mockReq, mockRes, mockNext);

      expect(mockRes.status).toHaveBeenCalledWith(404);
    });

    it('returns 403 when user is suspended', async () => {
      refreshSchema.parse.mockReturnValue({ refreshToken: 'some-token' });
      refreshUserToken.mockRejectedValue(
        createError(403, 'USER_SUSPENDED', 'User profile has been suspended.')
      );

      await refresh(mockReq, mockRes, mockNext);

      expect(mockRes.status).toHaveBeenCalledWith(403);
    });
  });
});
