const jwt = require('jsonwebtoken');

jest.mock('../../src/utils/token', () => {
  const actual = jest.requireActual('jsonwebtoken');
  const JWT_SECRET = 'supersecretactivationkeyherefordevelopment';
  return {
    generateAccessToken: jest.fn(user => actual.sign(
      { userId: user._id, madrasaId: user.madrasaId, role: user.role, permissions: user.permissions || [] },
      JWT_SECRET,
      { expiresIn: '15m' }
    )),
    generateRefreshToken: jest.fn(),
    verifyToken: jest.fn((token, type) => {
      return actual.verify(token, JWT_SECRET);
    }),
  };
});

const { requireAuth, requirePermission } = require('../../src/middleware/auth');

describe('Auth Middleware', () => {
  let mockReq;
  let mockRes;
  let mockNext;

  beforeEach(() => {
    mockReq = {
      headers: {},
      user: null,
    };
    mockRes = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn().mockReturnThis(),
    };
    mockNext = jest.fn();
  });

  describe('requireAuth', () => {
    it('returns 401 when Authorization header is missing', async () => {
      await requireAuth(mockReq, mockRes, mockNext);

      expect(mockRes.status).toHaveBeenCalledWith(401);
      expect(mockRes.json).toHaveBeenCalledWith({
        success: false,
        error: {
          code: 'UNAUTHORIZED',
          message: 'Access denied. Authorization token missing or malformed.',
        },
      });
      expect(mockNext).not.toHaveBeenCalled();
    });

    it('returns 401 when Authorization header does not start with Bearer', async () => {
      mockReq.headers.authorization = 'Basic some-token';

      await requireAuth(mockReq, mockRes, mockNext);

      expect(mockRes.status).toHaveBeenCalledWith(401);
      expect(mockRes.json).toHaveBeenCalledWith({
        success: false,
        error: {
          code: 'UNAUTHORIZED',
          message: 'Access denied. Authorization token missing or malformed.',
        },
      });
    });

    it('returns 401 with INVALID_TOKEN when token is invalid', async () => {
      mockReq.headers.authorization = 'Bearer invalid-token-here';

      await requireAuth(mockReq, mockRes, mockNext);

      expect(mockRes.status).toHaveBeenCalledWith(401);
      expect(mockRes.json).toHaveBeenCalledWith({
        success: false,
        error: {
          code: 'INVALID_TOKEN',
          message: 'Access denied. Invalid signature token.',
        },
      });
    });

    it('returns 401 with TOKEN_EXPIRED when token has expired', async () => {
      const { verifyToken } = require('../../src/utils/token');
      const expiredToken = require('jsonwebtoken').sign(
        { userId: 'test', madrasaId: 'test' },
        'supersecretactivationkeyherefordevelopment',
        { expiresIn: '0s' }
      );
      mockReq.headers.authorization = `Bearer ${expiredToken}`;

      await requireAuth(mockReq, mockRes, mockNext);

      expect(mockRes.status).toHaveBeenCalledWith(401);
      expect(mockRes.json).toHaveBeenCalledWith({
        success: false,
        error: {
          code: 'TOKEN_EXPIRED',
          message: 'Access token has expired.',
        },
      });
    });

    it('attaches decoded user to req and calls next for valid token', async () => {
      const jwt = require('jsonwebtoken');
      const JWT_SECRET = 'supersecretactivationkeyherefordevelopment';
      const validToken = jwt.sign(
        { userId: '60d5ec49c6d1a21e483e5891', madrasaId: '60d5ec49c6d1a21e483e5896', role: 'MadrasaAdmin', permissions: ['*'] },
        JWT_SECRET,
        { expiresIn: '15m' }
      );
      mockReq.headers.authorization = `Bearer ${validToken}`;

      await requireAuth(mockReq, mockRes, mockNext);

      expect(mockReq.user).toBeDefined();
      expect(mockReq.user.userId).toBe('60d5ec49c6d1a21e483e5891');
      expect(mockReq.user.role).toBe('MadrasaAdmin');
      expect(mockNext).toHaveBeenCalled();
    });
  });

  describe('requirePermission', () => {
    it('allows SuperAdmin with wildcard (*) permission', () => {
      mockReq.user = { permissions: ['*'] };
      const middleware = requirePermission('students:write');

      middleware(mockReq, mockRes, mockNext);

      expect(mockNext).toHaveBeenCalled();
      expect(mockRes.status).not.toHaveBeenCalled();
    });

    it('blocks request when user has no permissions property', () => {
      mockReq.user = {};
      const middleware = requirePermission('students:write');

      middleware(mockReq, mockRes, mockNext);

      expect(mockRes.status).toHaveBeenCalledWith(403);
      expect(mockRes.json).toHaveBeenCalledWith({
        success: false,
        error: {
          code: 'FORBIDDEN',
          message: 'Access denied. Missing permissions configuration.',
        },
      });
      expect(mockNext).not.toHaveBeenCalled();
    });

    it('blocks request when req.user is undefined', () => {
      mockReq.user = undefined;
      const middleware = requirePermission('students:write');

      middleware(mockReq, mockRes, mockNext);

      expect(mockRes.status).toHaveBeenCalledWith(403);
    });

    it('blocks request when user lacks required permission', () => {
      mockReq.user = { permissions: ['students:read'] };
      const middleware = requirePermission('students:write');

      middleware(mockReq, mockRes, mockNext);

      expect(mockRes.status).toHaveBeenCalledWith(403);
      expect(mockRes.json).toHaveBeenCalledWith({
        success: false,
        error: {
          code: 'FORBIDDEN',
          message: 'Access denied. Action requires permission scope: students:write',
        },
      });
    });

    it('allows request when user has the required permission', () => {
      mockReq.user = { permissions: ['students:read', 'students:write'] };
      const middleware = requirePermission('students:write');

      middleware(mockReq, mockRes, mockNext);

      expect(mockNext).toHaveBeenCalled();
    });

    it('handles multiple middleware calls correctly with different permissions', () => {
      mockReq.user = { permissions: ['students:read', 'attendance:write'] };

      const allowRead = requirePermission('students:read');
      const denyDelete = requirePermission('students:delete');

      allowRead(mockReq, mockRes, mockNext);
      expect(mockNext).toHaveBeenCalledTimes(1);

      denyDelete(mockReq, mockRes, mockNext);

      expect(mockRes.status).toHaveBeenCalledWith(403);
    });
  });
});
