const { studentCreateSchema, studentUpdateSchema, promoteSchema } = require('../validators/studentValidator');
const studentService = require('../services/studentService');
const { catchError } = require('../utils/errorHandler');

/**
 * Create a new student record
 * @param {import('express').Request} req - Express request object with validated body
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const createStudent = async (req, res, next) => {
  try {
    const validatedBody = studentCreateSchema.parse(req.body);
    const madrasaId = req.user.madrasaId;
    const student = await studentService.createStudent(madrasaId, validatedBody);
    res.status(201).json({ success: true, data: student });
  } catch (error) {
    catchError(error, res, next);
  }
};

/**
 * Retrieve a paginated list of students with optional filtering
 * @param {import('express').Request} req - Express request object with query params
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const getStudents = async (req, res, next) => {
  try {
    const madrasaId = req.user.madrasaId;
    const { students, meta } = await studentService.getStudents(madrasaId, req.query);
    res.status(200).json({ success: true, data: students, meta });
  } catch (error) {
    catchError(error, res, next);
  }
};

/**
 * Get a single student by ID
 * @param {import('express').Request} req - Express request object with student ID param
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const getStudentById = async (req, res, next) => {
  try {
    const student = await studentService.getStudentById(req.params.id, req.user.madrasaId);
    res.status(200).json({ success: true, data: student });
  } catch (error) {
    catchError(error, res, next);
  }
};

/**
 * Update an existing student record
 * @param {import('express').Request} req - Express request object with student ID and validated body
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const updateStudent = async (req, res, next) => {
  try {
    const validatedBody = studentUpdateSchema.parse(req.body);
    const student = await studentService.updateStudent(req.params.id, req.user.madrasaId, validatedBody);
    res.status(200).json({ success: true, data: student });
  } catch (error) {
    catchError(error, res, next);
  }
};

/**
 * Soft-delete (archive) a student record
 * @param {import('express').Request} req - Express request object with student ID param
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const deleteStudent = async (req, res, next) => {
  try {
    await studentService.deleteStudent(req.params.id, req.user.madrasaId);
    res.status(200).json({ success: true, message: 'Student profile successfully archived.' });
  } catch (error) {
    catchError(error, res, next);
  }
};

/**
 * Promote students to a target class
 * @param {import('express').Request} req - Express request object with student IDs and target class
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const promoteStudents = async (req, res, next) => {
  try {
    const { studentIds, targetClassId } = promoteSchema.parse(req.body);
    const madrasaId = req.user.madrasaId;
    const result = await studentService.promoteStudents(studentIds, targetClassId, madrasaId);
    res.status(200).json({ success: true, message: `Successfully promoted ${result.modifiedCount} of ${studentIds.length} students.`, modifiedCount: result.modifiedCount });
  } catch (error) {
    catchError(error, res, next);
  }
};

module.exports = { createStudent, getStudents, getStudentById, updateStudent, deleteStudent, promoteStudents };
