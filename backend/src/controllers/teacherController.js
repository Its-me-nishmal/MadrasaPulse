const { z } = require('zod');
const mongoose = require('mongoose');
const Teacher = require('../models/Teacher');

// Payload validation schemas
const assignmentSchema = z.object({
  classId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Class ID format'),
  subjectName: z.string().trim().min(1),
});

const teacherCreateSchema = z.object({
  staffId: z.string().trim().min(1),
  firstName: z.string().trim().min(1),
  lastName: z.string().trim().min(1),
  phone: z.string().trim().min(7),
  email: z.string().trim().email().optional().or(z.literal('')),
  qualifications: z.array(z.string()).default([]),
  assignedClasses: z.array(assignmentSchema).default([]),
});

const teacherUpdateSchema = teacherCreateSchema.partial();

/**
 * Onboard a new teacher profile
 */
const createTeacher = async (req, res, next) => {
  try {
    const validatedBody = teacherCreateSchema.parse(req.body);
    const madrasaId = req.user.madrasaId; // Tenant context

    // Check for duplicate staff ID under the tenant madrasa
    const existingTeacher = await Teacher.findOne({
      madrasaId,
      staffId: validatedBody.staffId,
      isDeleted: false,
    });

    if (existingTeacher) {
      return res.status(409).json({
        success: false,
        error: {
          code: 'STAFF_ID_EXISTS',
          message: `Teacher with staff ID ${validatedBody.staffId} is already onboarding.`,
        },
      });
    }

    const teacher = new Teacher({
      ...validatedBody,
      madrasaId,
    });

    await teacher.save();

    res.status(201).json({
      success: true,
      data: teacher,
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
 * Fetch paginated list of teachers with query filters
 */
const getTeachers = async (req, res, next) => {
  try {
    const madrasaId = req.user.madrasaId; // Tenant context
    let { page = 1, limit = 20, classId, subjectName, search } = req.query;

    page = Math.max(1, parseInt(page));
    limit = Math.min(100, Math.max(1, parseInt(limit)));

    const query = {
      madrasaId,
      isDeleted: false,
    };

    if (classId) {
      query['assignedClasses.classId'] = new mongoose.Types.ObjectId(classId);
    }

    if (subjectName) {
      query['assignedClasses.subjectName'] = { $regex: subjectName, $options: 'i' };
    }

    if (search) {
      query.$or = [
        { firstName: { $regex: search, $options: 'i' } },
        { lastName: { $regex: search, $options: 'i' } },
        { staffId: { $regex: search, $options: 'i' } },
      ];
    }

    const total = await Teacher.countDocuments(query);
    const pages = Math.ceil(total / limit);

    const teachers = await Teacher.find(query)
      .skip((page - 1) * limit)
      .limit(limit)
      .sort({ firstName: 1, lastName: 1 });

    res.status(200).json({
      success: true,
      data: teachers,
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
 * Retrieve individual teacher profile
 */
const getTeacherById = async (req, res, next) => {
  try {
    const teacher = await Teacher.findOne({
      _id: req.params.id,
      madrasaId: req.user.madrasaId,
      isDeleted: false,
    });

    if (!teacher) {
      return res.status(404).json({
        success: false,
        error: {
          code: 'TEACHER_NOT_FOUND',
          message: 'Teacher profile not found or belongs to another tenant.',
        },
      });
    }

    res.status(200).json({
      success: true,
      data: teacher,
    });
  } catch (error) {
    next(error);
  }
};

/**
 * Edit teacher profile details
 */
const updateTeacher = async (req, res, next) => {
  try {
    const validatedBody = teacherUpdateSchema.parse(req.body);

    const teacher = await Teacher.findOneAndUpdate(
      {
        _id: req.params.id,
        madrasaId: req.user.madrasaId,
        isDeleted: false,
      },
      { $set: validatedBody },
      { new: true, runValidators: true }
    );

    if (!teacher) {
      return res.status(404).json({
        success: false,
        error: {
          code: 'TEACHER_NOT_FOUND',
          message: 'Teacher profile not found or belongs to another tenant.',
        },
      });
    }

    res.status(200).json({
      success: true,
      data: teacher,
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
 * Soft delete teacher profile
 */
const deleteTeacher = async (req, res, next) => {
  try {
    const teacher = await Teacher.findOneAndUpdate(
      {
        _id: req.params.id,
        madrasaId: req.user.madrasaId,
        isDeleted: false,
      },
      { $set: { isDeleted: true } },
      { new: true }
    );

    if (!teacher) {
      return res.status(404).json({
        success: false,
        error: {
          code: 'TEACHER_NOT_FOUND',
          message: 'Teacher profile not found or belongs to another tenant.',
        },
      });
    }

    res.status(200).json({
      success: true,
      message: 'Teacher profile successfully archived.',
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  createTeacher,
  getTeachers,
  getTeacherById,
  updateTeacher,
  deleteTeacher,
};
