const mongoose = require('mongoose');

const mockStudent = {
  _id: '60d5ec49c6d1a21e483e5892',
  madrasaId: '60d5ec49c6d1a21e483e5896',
  admissionNo: 'STU-001',
  firstName: 'Aisha',
  lastName: 'Rahman',
  dateOfBirth: new Date('2016-04-12'),
  classId: '60d5ec49c6d1a21e483e5890',
  guardians: [{ name: 'Imran Rahman', relationship: 'Father', phone: '+919988776655', isPrimary: true }],
  isDeleted: false,
  save: jest.fn().mockResolvedValue(),
};

jest.mock('../../src/models/Student', () => {
  const mockModel = function (data) {
    Object.assign(this, data);
    this._id = mockStudent._id;
    this.save = jest.fn().mockResolvedValue(this);
  };
  mockModel.findOne = jest.fn();
  mockModel.findById = jest.fn();
  mockModel.countDocuments = jest.fn();
  mockModel.find = jest.fn();
  mockModel.findOneAndUpdate = jest.fn();
  mockModel.updateMany = jest.fn();
  mockModel.prototype.save = jest.fn().mockResolvedValue({});
  return mockModel;
});

jest.mock('mongoose', () => {
  const actual = jest.requireActual('mongoose');
  class MockObjectId {
    constructor(id) {
      this.id = id;
    }
    toString() { return this.id; }
  }
  return {
    ...actual,
    Types: {
      ...actual.Types,
      ObjectId: MockObjectId,
    },
  };
});

const Student = require('../../src/models/Student');
const studentService = require('../../src/services/studentService');

const MADRASA_ID = '60d5ec49c6d1a21e483e5896';

describe('Student Service', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('createStudent', () => {
    const validData = {
      admissionNo: 'STU-001',
      firstName: 'Aisha',
      lastName: 'Rahman',
      dateOfBirth: new Date('2016-04-12'),
      classId: '60d5ec49c6d1a21e483e5890',
      guardians: [{ name: 'Imran Rahman', relationship: 'Father', phone: '+919988776655', isPrimary: true }],
    };

    it('creates and returns a student for unique admission number', async () => {
      Student.findOne.mockResolvedValue(null);
      Student.prototype.save.mockResolvedValue(mockStudent);

      const result = await studentService.createStudent(MADRASA_ID, validData);

      expect(Student.findOne).toHaveBeenCalledWith({
        madrasaId: MADRASA_ID,
        admissionNo: validData.admissionNo,
        isDeleted: false,
      });
      expect(result).toBeDefined();
      expect(result.firstName).toBe('Aisha');
    });

    it('rejects duplicate admission number within the same madrasa', async () => {
      Student.findOne.mockResolvedValue(mockStudent);

      await expect(studentService.createStudent(MADRASA_ID, validData)).rejects.toThrow(
        'Admission number STU-001 is already registered.'
      );
      await expect(studentService.createStudent(MADRASA_ID, validData)).rejects.toMatchObject({
        statusCode: 409,
        code: 'ADMISSION_EXISTS',
      });
    });
  });

  describe('getStudents', () => {
    it('returns paginated student results', async () => {
      Student.countDocuments.mockResolvedValue(1);
      Student.find.mockReturnValue({
        skip: jest.fn().mockReturnValue({
          limit: jest.fn().mockReturnValue({
            sort: jest.fn().mockResolvedValue([mockStudent]),
          }),
        }),
      });

      const result = await studentService.getStudents(MADRASA_ID, {});

      expect(result.students).toHaveLength(1);
      expect(result.meta).toEqual({ total: 1, page: 1, limit: 20, pages: 1 });
    });

    it('filters by classId when provided', async () => {
      Student.countDocuments.mockResolvedValue(0);
      Student.find.mockReturnValue({
        skip: jest.fn().mockReturnValue({
          limit: jest.fn().mockReturnValue({
            sort: jest.fn().mockResolvedValue([]),
          }),
        }),
      });

      await studentService.getStudents(MADRASA_ID, { classId: '60d5ec49c6d1a21e483e5890' });

      const queryArg = Student.countDocuments.mock.calls[0][0];
      expect(queryArg).toHaveProperty('madrasaId', MADRASA_ID);
      expect(queryArg).toHaveProperty('isDeleted', false);
      expect(queryArg).toHaveProperty('classId');
      expect(queryArg.classId.toString()).toBe('60d5ec49c6d1a21e483e5890');
    });

    it('filters by search term using $or on name and admissionNo fields', async () => {
      Student.countDocuments.mockResolvedValue(0);
      Student.find.mockReturnValue({
        skip: jest.fn().mockReturnValue({
          limit: jest.fn().mockReturnValue({
            sort: jest.fn().mockResolvedValue([]),
          }),
        }),
      });

      await studentService.getStudents(MADRASA_ID, { search: 'Aisha' });

      expect(Student.countDocuments).toHaveBeenCalledWith(
        expect.objectContaining({
          $or: [
            { firstName: { $regex: 'Aisha', $options: 'i' } },
            { lastName: { $regex: 'Aisha', $options: 'i' } },
            { admissionNo: { $regex: 'Aisha', $options: 'i' } },
          ],
        })
      );
    });

    it('clamps page and limit to valid ranges', async () => {
      Student.countDocuments.mockResolvedValue(0);
      Student.find.mockReturnValue({
        skip: jest.fn().mockReturnValue({
          limit: jest.fn().mockReturnValue({
            sort: jest.fn().mockResolvedValue([]),
          }),
        }),
      });

      const result = await studentService.getStudents(MADRASA_ID, { page: '-1', limit: '500' });

      expect(result.meta.page).toBe(1);
      expect(result.meta.limit).toBe(100);
    });
  });

  describe('getStudentById', () => {
    it('returns the correct student for valid id and madrasa', async () => {
      Student.findOne.mockResolvedValue(mockStudent);

      const result = await studentService.getStudentById(mockStudent._id, MADRASA_ID);

      expect(Student.findOne).toHaveBeenCalledWith({
        _id: mockStudent._id,
        madrasaId: MADRASA_ID,
        isDeleted: false,
      });
      expect(result._id).toBe(mockStudent._id);
    });

    it('throws STUDENT_NOT_FOUND when student does not exist', async () => {
      Student.findOne.mockResolvedValue(null);

      await expect(studentService.getStudentById('nonexistent', MADRASA_ID)).rejects.toMatchObject({
        statusCode: 404,
        code: 'STUDENT_NOT_FOUND',
      });
    });
  });

  describe('updateStudent', () => {
    it('modifies and returns the updated student', async () => {
      const updatedData = { firstName: 'Aisha Updated' };
      const updatedStudent = { ...mockStudent, firstName: 'Aisha Updated' };
      Student.findOneAndUpdate.mockResolvedValue(updatedStudent);

      const result = await studentService.updateStudent(mockStudent._id, MADRASA_ID, updatedData);

      expect(Student.findOneAndUpdate).toHaveBeenCalledWith(
        { _id: mockStudent._id, madrasaId: MADRASA_ID, isDeleted: false },
        { $set: updatedData },
        { new: true, runValidators: true }
      );
      expect(result.firstName).toBe('Aisha Updated');
    });

    it('throws STUDENT_NOT_FOUND when student not found', async () => {
      Student.findOneAndUpdate.mockResolvedValue(null);

      await expect(studentService.updateStudent('nonexistent', MADRASA_ID, {}))
        .rejects.toMatchObject({ statusCode: 404, code: 'STUDENT_NOT_FOUND' });
    });
  });

  describe('deleteStudent', () => {
    it('soft-deletes the student by setting isDeleted to true', async () => {
      const deletedStudent = { ...mockStudent, isDeleted: true };
      Student.findOneAndUpdate.mockResolvedValue(deletedStudent);

      const result = await studentService.deleteStudent(mockStudent._id, MADRASA_ID);

      expect(Student.findOneAndUpdate).toHaveBeenCalledWith(
        { _id: mockStudent._id, madrasaId: MADRASA_ID, isDeleted: false },
        { $set: { isDeleted: true } },
        { new: true }
      );
      expect(result.isDeleted).toBe(true);
    });

    it('throws STUDENT_NOT_FOUND when student not found', async () => {
      Student.findOneAndUpdate.mockResolvedValue(null);

      await expect(studentService.deleteStudent('nonexistent', MADRASA_ID))
        .rejects.toMatchObject({ statusCode: 404, code: 'STUDENT_NOT_FOUND' });
    });
  });

  describe('promoteStudents', () => {
    it('bulk updates classId for the given student IDs', async () => {
      const targetClassId = '60d5ec49c6d1a21e483e5899';
      Student.updateMany.mockResolvedValue({ modifiedCount: 1, matchedCount: 1 });

      const result = await studentService.promoteStudents(
        [mockStudent._id],
        targetClassId,
        MADRASA_ID
      );

      const filterArg = Student.updateMany.mock.calls[0][0];
      const updateArg = Student.updateMany.mock.calls[0][1];
      expect(filterArg).toMatchObject({ _id: { $in: [mockStudent._id] }, madrasaId: MADRASA_ID, isDeleted: false });
      expect(updateArg).toHaveProperty('$set');
      expect(updateArg.$set.classId.toString()).toBe(targetClassId);
      expect(result.modifiedCount).toBe(1);
    });
  });
});
