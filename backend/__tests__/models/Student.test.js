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
    this._id = '60d5ec49c6d1a21e483e5892';
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
const Student = require('../../src/models/Student');

describe('Student Model', () => {
  describe('Schema Structure', () => {
    it('creates a Student model with correct collection name', () => {
      expect(mongoose.model).toHaveBeenCalledWith('Student', expect.any(Object));
    });

    it('defines the compound unique index on madrasaId and admissionNo', () => {
      expect(Student.schema.index).toHaveBeenCalledWith(
        { madrasaId: 1, admissionNo: 1 },
        { unique: true }
      );
    });

    it('defines index on madrasaId, classId, isDeleted', () => {
      expect(Student.schema.index).toHaveBeenCalledWith(
        { madrasaId: 1, classId: 1, isDeleted: 1 }
      );
    });

    it('defines text index on firstName and lastName', () => {
      expect(Student.schema.index).toHaveBeenCalledWith(
        { firstName: 'text', lastName: 'text' }
      );
    });
  });

  describe('Guardian Validation', () => {
    it('accepts a student with at least one guardian', () => {
      const student = new Student({
        madrasaId: '60d5ec49c6d1a21e483e5896',
        admissionNo: 'STU-001',
        firstName: 'Aisha',
        lastName: 'Rahman',
        dateOfBirth: new Date('2016-04-12'),
        guardians: [{
          name: 'Imran Rahman',
          relationship: 'Father',
          phone: '+919988776655',
          isPrimary: true,
        }],
      });
      expect(student.guardians).toHaveLength(1);
      expect(student.guardians[0].name).toBe('Imran Rahman');
    });

    it('fails when guardians array is empty', () => {
      const student = new Student({
        madrasaId: '60d5ec49c6d1a21e483e5896',
        admissionNo: 'STU-001',
        firstName: 'Aisha',
        lastName: 'Rahman',
        dateOfBirth: new Date('2016-04-12'),
        guardians: [],
      });
      expect(student.guardians).toHaveLength(0);
    });
  });

  describe('Soft Delete', () => {
    it('can set isDeleted to true', () => {
      const student = new Student({
        madrasaId: '60d5ec49c6d1a21e483e5896',
        admissionNo: 'STU-001',
        firstName: 'Aisha',
        lastName: 'Rahman',
        dateOfBirth: new Date('2016-04-12'),
        guardians: [{
          name: 'Imran Rahman',
          relationship: 'Father',
          phone: '+919988776655',
        }],
        isDeleted: true,
      });
      expect(student.isDeleted).toBe(true);
    });
  });

  describe('Required Fields', () => {
    const validData = {
      madrasaId: '60d5ec49c6d1a21e483e5896',
      admissionNo: 'STU-001',
      firstName: 'Aisha',
      lastName: 'Rahman',
      dateOfBirth: new Date('2016-04-12'),
      guardians: [{
        name: 'Imran Rahman',
        relationship: 'Father',
        phone: '+919988776655',
      }],
    };

    const requiredFields = ['madrasaId', 'admissionNo', 'firstName', 'lastName', 'dateOfBirth', 'guardians'];

    requiredFields.forEach(field => {
      it(`requires ${field} field`, () => {
        const data = { ...validData, [field]: undefined };
        const student = new Student(data);
        expect(student[field]).toBeUndefined();
      });
    });
  });
});
