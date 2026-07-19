const { z } = require('zod');
const mongoose = require('mongoose');
const Student = require('../models/Student');

// Payload validation schemas
const guardianSchema = z.object({
  name: z.string().trim().min(2),
  relationship: z.enum(['Father', 'Mother', 'Grandfather', 'Grandmother', 'Uncle', 'Aunt', 'Brother', 'Sister', 'Guardian']),
  phone: z.string().trim().min(7),
  isPrimary: z.boolean().default(false),
});

const studentCreateSchema = z.object({
  admissionNo: z.string().trim().min(1),
  rollNo: z.string().trim().optional(),
  firstName: z.string().trim().min(1),
  lastName: z.string().trim().min(1),
  dateOfBirth: z.string().transform(val => new Date(val)),
  classId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Class ID format').optional(),
  guardians: z.array(guardianSchema).min(1, 'At least one guardian contact is required'),
});

const studentUpdateSchema = studentCreateSchema.partial();

const promoteSchema = z.object({
  studentIds: z.array(z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Student ID format')).min(1),
  targetClassId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Class ID format'),
});

/**
 * Register a new student profile
 */
const createStudent = async (req, res, next) => {
  try {
    const validatedBody = studentCreateSchema.parse(req.body);
    const madrasaId = req.user.madrasaId; // Tenant context

    // Check for duplicate admission number under the tenant madrasa
    const existingStudent = await Student.findOne({
      madrasaId,
      admissionNo: validatedBody.admissionNo,
      isDeleted: false,
    });

    if (existingStudent) {
      return res.status(409).json({
        success: false,
        error: {
          code: 'ADMISSION_EXISTS',
          message: `Admission number ${validatedBody.admissionNo} is already registered.`,
        },
      });
    }

    const student = new Student({
      ...validatedBody,
      madrasaId,
    });

    await student.save();

    res.status(201).json({
      success: true,
      data: student,
    });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({
        success: false,
        error: {
          code: 'VALIDATION_FAILED',
          message: 'Invalid request payload parameters.',
          details: error.errors.map(err => ({ field: err.path.join('.'), issue: err.message })),
        },
      });
    }
    next(error);
  }
};

/**
 * Fetch paginated list of students with query filters
 */
const getStudents = async (req, res, next) => {
  try {
    const madrasaId = req.user.madrasaId; // Tenant context
    let { page = 1, limit = 20, classId, search } = req.query;

    page = Math.max(1, parseInt(page));
    limit = Math.min(100, Math.max(1, parseInt(limit)));

    const query = {
      madrasaId,
      isDeleted: false,
    };

    if (classId) {
      query.classId = new mongoose.Types.ObjectId(classId);
    }

    if (search) {
      // Use text index search if available, falling back to regex search on name fields
      query.$or = [
        { firstName: { $regex: search, $options: 'i' } },
        { lastName: { $regex: search, $options: 'i' } },
        { admissionNo: { $regex: search, $options: 'i' } },
      ];
    }

    const total = await Student.countDocuments(query);
    const pages = Math.ceil(total / limit);

    const students = await Student.find(query)
      .skip((page - 1) * limit)
      .limit(limit)
      .sort({ firstName: 1, lastName: 1 });

    res.status(200).json({
      success: true,
      data: students,
      meta: {
        total,
        page,
        limit,
        pages,
      },
    });
  } catch (error) {
    next(error);
  }
};

/**
 * Retrieve individual student profile
 */
const getStudentById = async (req, res, next) => {
  try {
    const student = await Student.findOne({
      _id: req.params.id,
      madrasaId: req.user.madrasaId,
      isDeleted: false,
    });

    if (!student) {
      return res.status(404).json({
        success: false,
        error: {
          code: 'STUDENT_NOT_FOUND',
          message: 'Student profile not found or belongs to another tenant.',
        },
      });
    }

    res.status(200).json({
      success: true,
      data: student,
    });
  } catch (error) {
    next(error);
  }
};

/**
 * Edit student profile
 */
const updateStudent = async (req, res, next) => {
  try {
    const validatedBody = studentUpdateSchema.parse(req.body);

    const student = await Student.findOneAndUpdate(
      {
        _id: req.params.id,
        madrasaId: req.user.madrasaId,
        isDeleted: false,
      },
      { $set: validatedBody },
      { new: true, runValidators: true }
    );

    if (!student) {
      return res.status(404).json({
        success: false,
        error: {
          code: 'STUDENT_NOT_FOUND',
          message: 'Student profile not found or belongs to another tenant.',
        },
      });
    }

    res.status(200).json({
      success: true,
      data: student,
    });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({
        success: false,
        error: {
          code: 'VALIDATION_FAILED',
          message: 'Invalid input payload.',
          details: error.errors.map(err => ({ field: err.path.join('.'), issue: err.message })),
        },
      });
    }
    next(error);
  }
};

/**
 * Soft delete student
 */
const deleteStudent = async (req, res, next) => {
  try {
    const student = await Student.findOneAndUpdate(
      {
        _id: req.params.id,
        madrasaId: req.user.madrasaId,
        isDeleted: false,
      },
      { $set: { isDeleted: true } },
      { new: true }
    );

    if (!student) {
      return res.status(404).json({
        success: false,
        error: {
          code: 'STUDENT_NOT_FOUND',
          message: 'Student profile not found or belongs to another tenant.',
        },
      });
    }

    res.status(200).json({
      success: true,
      message: 'Student profile successfully archived.',
    });
  } catch (error) {
    next(error);
  }
};

/**
 * Bulk promote students
 */
const promoteStudents = async (req, res, next) => {
  try {
    const { studentIds, targetClassId } = promoteSchema.parse(req.body);
    const madrasaId = req.user.madrasaId;

    const result = await Student.updateMany(
      {
        _id: { $in: studentIds },
        madrasaId,
        isDeleted: false,
      },
      {
        $set: { classId: new mongoose.Types.ObjectId(targetClassId) },
      }
    );

    res.status(200).json({
      success: true,
      message: `Successfully promoted ${result.modifiedCount} of ${studentIds.length} students.`,
      modifiedCount: result.modifiedCount,
    });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({
        success: false,
        error: {
          code: 'VALIDATION_FAILED',
          message: 'Invalid promote request payload.',
          details: error.errors.map(err => ({ field: err.path.join('.'), issue: err.message })),
        },
      });
    }
    next(error);
  }
};

module.exports = {
  createStudent,
  getStudents,
  getStudentById,
  updateStudent,
  deleteStudent,
  promoteStudents,
};
