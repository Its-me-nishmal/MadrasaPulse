const bcrypt = require('bcryptjs');

const mockSchemaTypes = {
  ObjectId: 'ObjectId',
  String: String,
  Boolean: Boolean,
  Number: Number,
  Date: Date,
};

jest.mock('mongoose', () => {
  const preSaveHooks = [];
  const modelMethods = {};
  const mockSchema = {
    pre: jest.fn((event, fn) => {
      if (event === 'save') preSaveHooks.push(fn);
      return mockSchema;
    }),
    index: jest.fn().mockReturnThis(),
    virtual: jest.fn().mockReturnThis(),
    add: jest.fn().mockReturnThis(),
    methods: modelMethods,
  };

  const Schema = function () { return mockSchema; };
  Schema.Types = mockSchemaTypes;

  const mockModel = function (data) {
    Object.assign(this, data);
    this._id = '60d5ec49c6d1a21e483e5891';
    this.isNew = true;
  };
  mockModel.prototype.save = jest.fn().mockResolvedValue();
  mockModel.schema = mockSchema;
  mockModel.findOne = jest.fn();
  mockModel.findById = jest.fn();
  mockModel.countDocuments = jest.fn();
  mockModel.find = jest.fn();
  mockModel.findOneAndUpdate = jest.fn();
  mockModel.updateMany = jest.fn();
  mockModel.create = jest.fn();

  return {
    Schema,
    model: jest.fn(() => mockModel),
    Types: mockSchemaTypes,
    connection: { readyState: 1 },
    connect: jest.fn(),
  };
});

const mongoose = require('mongoose');
const User = require('../../src/models/User');

describe('User Model', () => {
  describe('Schema Structure', () => {
    it('creates a User model with correct collection name', () => {
      expect(mongoose.model).toHaveBeenCalledWith('User', expect.any(Object));
    });

    it('defines the compound unique index on madrasaId and username', () => {
      const schema = User.schema;
      expect(schema.index).toHaveBeenCalledWith(
        { madrasaId: 1, username: 1 },
        { unique: true }
      );
    });

    it('defines index on madrasaId and role', () => {
      const schema = User.schema;
      expect(schema.index).toHaveBeenCalledWith(
        { madrasaId: 1, role: 1 }
      );
    });

    it('defines index on isActive', () => {
      const schema = User.schema;
      expect(schema.index).toHaveBeenCalledWith({ isActive: 1 });
    });
  });

  describe('Pre-save Hook - Password Hashing', () => {
    it('registers a pre-save hook', () => {
      expect(User.schema.pre).toHaveBeenCalledWith('save', expect.any(Function));
    });

    it('hashes passwordHash when field is modified', async () => {
      const salt = await bcrypt.genSalt(10);
      const hashedPassword = await bcrypt.hash('mySecurePass123', salt);

      const preSaveFn = User.schema.pre.mock.calls.find(call => call[0] === 'save')[1];
      const mockNext = jest.fn();
      const mockThis = {
        isModified: jest.fn(() => true),
        passwordHash: 'mySecurePass123',
      };

      await preSaveFn.call(mockThis, mockNext);

      expect(mockThis.isModified).toHaveBeenCalledWith('passwordHash');
      expect(mockThis.passwordHash).not.toBe('mySecurePass123');
      expect(mockThis.passwordHash).toMatch(/^\$2[ab]\$\d+\$/); // bcrypt hash pattern
      expect(mockNext).toHaveBeenCalled();
    });

    it('skips hashing when passwordHash is not modified', async () => {
      const preSaveFn = User.schema.pre.mock.calls.find(call => call[0] === 'save')[1];
      const mockNext = jest.fn();
      const mockThis = {
        isModified: jest.fn(() => false),
        passwordHash: 'already-hashed-value',
      };

      await preSaveFn.call(mockThis, mockNext);

      expect(mockThis.passwordHash).toBe('already-hashed-value');
      expect(mockNext).toHaveBeenCalled();
    });
  });

  describe('comparePassword Method', () => {
    it('returns true when candidate password matches', async () => {
      const salt = await bcrypt.genSalt(10);
      const hashedPassword = await bcrypt.hash('correctPassword', salt);

      const methodFn = User.schema.methods.comparePassword;
      const result = await methodFn.call({ passwordHash: hashedPassword }, 'correctPassword');
      expect(result).toBe(true);
    });

    it('returns false when candidate password does not match', async () => {
      const salt = await bcrypt.genSalt(10);
      const hashedPassword = await bcrypt.hash('correctPassword', salt);

      const methodFn = User.schema.methods.comparePassword;
      const result = await methodFn.call({ passwordHash: hashedPassword }, 'wrongPassword');
      expect(result).toBe(false);
    });
  });
});
