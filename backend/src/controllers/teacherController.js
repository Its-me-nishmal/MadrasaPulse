const { teacherCreateSchema, teacherUpdateSchema } = require('../validators/teacherValidator');
const teacherService = require('../services/teacherService');
const { catchError } = require('../utils/errorHandler');

/**
 * Create a new teacher record
 * @param {import('express').Request} req - Express request object with validated body
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const createTeacher = async (req, res, next) => {
  try {
    const validatedBody = teacherCreateSchema.parse(req.body);
    const madrasaId = req.user.madrasaId;
    const teacher = await teacherService.createTeacher(madrasaId, validatedBody);
    res.status(201).json({ success: true, data: teacher });
  } catch (error) {
    catchError(error, res, next);
  }
};

/**
 * Retrieve a paginated list of teachers with optional filtering
 * @param {import('express').Request} req - Express request object with query params
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const getTeachers = async (req, res, next) => {
  try {
    const madrasaId = req.user.madrasaId;
    const { teachers, meta } = await teacherService.getTeachers(madrasaId, req.query);
    res.status(200).json({ success: true, data: teachers, meta });
  } catch (error) {
    catchError(error, res, next);
  }
};

/**
 * Get a single teacher by ID
 * @param {import('express').Request} req - Express request object with teacher ID param
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const getTeacherById = async (req, res, next) => {
  try {
    const teacher = await teacherService.getTeacherById(req.params.id, req.user.madrasaId);
    res.status(200).json({ success: true, data: teacher });
  } catch (error) {
    catchError(error, res, next);
  }
};

/**
 * Update an existing teacher record
 * @param {import('express').Request} req - Express request object with teacher ID and validated body
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const updateTeacher = async (req, res, next) => {
  try {
    const validatedBody = teacherUpdateSchema.parse(req.body);
    const teacher = await teacherService.updateTeacher(req.params.id, req.user.madrasaId, validatedBody);
    res.status(200).json({ success: true, data: teacher });
  } catch (error) {
    catchError(error, res, next);
  }
};

/**
 * Soft-delete (archive) a teacher record
 * @param {import('express').Request} req - Express request object with teacher ID param
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const deleteTeacher = async (req, res, next) => {
  try {
    await teacherService.deleteTeacher(req.params.id, req.user.madrasaId);
    res.status(200).json({ success: true, message: 'Teacher profile successfully archived.' });
  } catch (error) {
    catchError(error, res, next);
  }
};

module.exports = { createTeacher, getTeachers, getTeacherById, updateTeacher, deleteTeacher };
