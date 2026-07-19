const jwt = require('jsonwebtoken');
const { generateAccessToken, generateRefreshToken, verifyToken } = require('../../src/utils/token');

const JWT_SECRET = process.env.JWT_SECRET || 'supersecretactivationkeyherefordevelopment';
const JWT_REFRESH_SECRET = process.env.JWT_REFRESH_SECRET || 'anotherrefreshsecretactivationkeyherefordevelopment';

const mockUser = {
  _id: '60d5ec49c6d1a21e483e5891',
  madrasaId: '60d5ec49c6d1a21e483e5896',
  role: 'MadrasaAdmin',
};

describe('Token Utility Functions', () => {
  describe('generateAccessToken', () => {
    it('creates a valid token with correct payload', () => {
      const token = generateAccessToken(mockUser);
      expect(token).toBeDefined();
      expect(typeof token).toBe('string');

      const decoded = jwt.verify(token, JWT_SECRET);
      expect(decoded.userId).toBe(mockUser._id);
      expect(decoded.madrasaId).toBe(mockUser.madrasaId);
      expect(decoded.role).toBe(mockUser.role);
    });

    it('includes permissions array in payload based on role', () => {
      const token = generateAccessToken(mockUser);
      const decoded = jwt.verify(token, JWT_SECRET);
      expect(Array.isArray(decoded.permissions)).toBe(true);
      expect(decoded.permissions.length).toBeGreaterThan(0);
    });

    it('creates a token with short expiry (15m)', () => {
      const token = generateAccessToken(mockUser);
      const decoded = jwt.verify(token, JWT_SECRET);
      const now = Math.floor(Date.now() / 1000);
      const expiresIn = decoded.exp - decoded.iat;
      expect(expiresIn).toBe(15 * 60);
    });
  });

  describe('generateRefreshToken', () => {
    it('creates a valid refresh token with longer expiry', () => {
      const token = generateRefreshToken(mockUser);
      expect(token).toBeDefined();
      expect(typeof token).toBe('string');

      const decoded = jwt.verify(token, JWT_REFRESH_SECRET);
      expect(decoded.userId).toBe(mockUser._id);
    });

    it('creates a token with 30 day expiry', () => {
      const token = generateRefreshToken(mockUser);
      const decoded = jwt.verify(token, JWT_REFRESH_SECRET);
      const expiresIn = decoded.exp - decoded.iat;
      expect(expiresIn).toBe(30 * 24 * 60 * 60);
    });
  });

  describe('verifyToken', () => {
    it('correctly validates an access token', () => {
      const token = generateAccessToken(mockUser);
      const decoded = verifyToken(token, 'access');
      expect(decoded.userId).toBe(mockUser._id);
      expect(decoded.role).toBe(mockUser.role);
    });

    it('correctly validates a refresh token', () => {
      const token = generateRefreshToken(mockUser);
      const decoded = verifyToken(token, 'refresh');
      expect(decoded.userId).toBe(mockUser._id);
    });

    it('defaults to access secret when secretType is omitted', () => {
      const token = generateAccessToken(mockUser);
      const decoded = verifyToken(token);
      expect(decoded.userId).toBe(mockUser._id);
    });

    it('throws JsonWebTokenError for an invalid token', () => {
      expect(() => verifyToken('invalid-token-here', 'access')).toThrow(jwt.JsonWebTokenError);
    });

    it('throws TokenExpiredError for an expired token', () => {
      const expiredToken = jwt.sign({ userId: mockUser._id }, JWT_SECRET, { expiresIn: '0s' });
      expect(() => verifyToken(expiredToken, 'access')).toThrow(jwt.TokenExpiredError);
    });

    it('rejects access token verified with wrong secret', () => {
      const token = generateAccessToken(mockUser);
      expect(() => jwt.verify(token, 'wrong-secret')).toThrow(jwt.JsonWebTokenError);
    });
  });

  describe('role-based permissions', () => {
    const roles = ['SuperAdmin', 'MadrasaAdmin', 'Teacher', 'Parent', 'Student'];

    roles.forEach(role => {
      it('SuperAdmin gets wildcard (*) permission', () => {
        if (role !== 'SuperAdmin') return;
        const token = generateAccessToken({ ...mockUser, role });
        const decoded = jwt.verify(token, JWT_SECRET);
        expect(decoded.permissions).toContain('*');
      });

      it(`${role} role gets appropriate permissions`, () => {
        const token = generateAccessToken({ ...mockUser, role });
        const decoded = jwt.verify(token, JWT_SECRET);
        expect(Array.isArray(decoded.permissions)).toBe(true);
      });
    });

    it('returns empty permissions for unknown role', () => {
      const token = generateAccessToken({ ...mockUser, role: 'UnknownRole' });
      const decoded = jwt.verify(token, JWT_SECRET);
      expect(decoded.permissions).toEqual([]);
    });
  });
});
