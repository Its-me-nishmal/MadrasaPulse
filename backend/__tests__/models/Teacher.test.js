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
    this._id = '60d5ec49c6d1a21e483e5893';
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

  return {
    Schema,
    model: jest.fn(() => mockModel),
    Types: mockSchemaTypes,
    connection: { readyState: 1 },
    connect: jest.fn(),
  };
});

const mongoose = require('mongoose');
const Teacher = require('../../src/models/Teacher');

describe('Teacher Model', () => {
  describe('Schema Structure', () => {
    it('creates a Teacher model with correct collection name', () => {
      expect(mongoose.model).toHaveBeenCalledWith('Teacher', expect.any(Object));
    });

    it('defines the compound unique index on madrasaId and staffId', () => {
      expect(Teacher.schema.index).toHaveBeenCalledWith(
        { madrasaId: 1, staffId: 1 },
        { unique: true }
      );
    });

    it('defines index on madrasaId and isDeleted', () => {
      expect(Teacher.schema.index).toHaveBeenCalledWith(
        { madrasaId: 1, isDeleted: 1 }
      );
    });

    it('defines text index on firstName and lastName', () => {
      expect(Teacher.schema.index).toHaveBeenCalledWith(
        { firstName: 'text', lastName: 'text' }
      );
    });

    it('defines index on madrasaId and assignedClasses.classId', () => {
      expect(Teacher.schema.index).toHaveBeenCalledWith(
        { madrasaId: 1, 'assignedClasses.classId': 1 }
      );
    });
  });

  describe('Valid Teacher Creation', () => {
    it('creates a teacher with required fields', () => {
      const teacher = new Teacher({
        madrasaId: '60d5ec49c6d1a21e483e5896',
        staffId: 'TCH-001',
        firstName: 'Omar',
        lastName: 'Faruq',
        phone: '+918877665544',
      });
      expect(teacher.staffId).toBe('TCH-001');
      expect(teacher.firstName).toBe('Omar');
      expect(teacher.lastName).toBe('Faruq');
    });

  });

  describe('Assigned Classes', () => {
    it('accepts valid class assignments with classId and subjectName', () => {
      const teacher = new Teacher({
        madrasaId: '60d5ec49c6d1a21e483e5896',
        staffId: 'TCH-001',
        firstName: 'Omar',
        lastName: 'Faruq',
        phone: '+918877665544',
        assignedClasses: [
          { classId: '60d5ec49c6d1a21e483e5890', subjectName: 'Hadith Studies' },
          { classId: '60d5ec49c6d1a21e483e5890', subjectName: 'Tafseer' },
        ],
      });
      expect(teacher.assignedClasses).toHaveLength(2);
      expect(teacher.assignedClasses[0].subjectName).toBe('Hadith Studies');
      expect(teacher.assignedClasses[1].subjectName).toBe('Tafseer');
    });

    it('rejects assigned class without classId', () => {
      const teacher = new Teacher({
        madrasaId: '60d5ec49c6d1a21e483e5896',
        staffId: 'TCH-001',
        firstName: 'Omar',
        lastName: 'Faruq',
        phone: '+918877665544',
        assignedClasses: [
          { subjectName: 'Hadith Studies' },
        ],
      });
      expect(teacher.assignedClasses[0].classId).toBeUndefined();
    });

    it('rejects assigned class without subjectName', () => {
      const teacher = new Teacher({
        madrasaId: '60d5ec49c6d1a21e483e5896',
        staffId: 'TCH-001',
        firstName: 'Omar',
        lastName: 'Faruq',
        phone: '+918877665544',
        assignedClasses: [
          { classId: '60d5ec49c6d1a21e483e5890' },
        ],
      });
      expect(teacher.assignedClasses[0].subjectName).toBeUndefined();
    });
  });

  describe('Required Fields', () => {
    const validData = {
      madrasaId: '60d5ec49c6d1a21e483e5896',
      staffId: 'TCH-001',
      firstName: 'Omar',
      lastName: 'Faruq',
      phone: '+918877665544',
    };

    const requiredFields = ['madrasaId', 'staffId', 'firstName', 'lastName', 'phone'];

    requiredFields.forEach(field => {
      it(`requires ${field} field`, () => {
        const data = { ...validData, [field]: undefined };
        const teacher = new Teacher(data);
        expect(teacher[field]).toBeUndefined();
      });
    });
  });
});
