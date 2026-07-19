const { submitMarksSchema, classMarksQuerySchema } = require('../validators/examValidator');
const examService = require('../services/examService');
const { catchError } = require('../utils/errorHandler');

/**
 * Submit or update exam marks for a class subject
 * @param {import('express').Request} req - Express request object with validated marks data
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const submitMarks = async (req, res, next) => {
  try {
    const validatedBody = submitMarksSchema.parse(req.body);
    const madrasaId = req.user.madrasaId;
    const record = await examService.submitMarks(madrasaId, validatedBody);
    res.status(200).json({ success: true, message: 'Exam marks successfully recorded.', data: record });
  } catch (error) {
    catchError(error, res, next);
  }
};

/**
 * Retrieve marks for a class, exam, and subject combination
 * @param {import('express').Request} req - Express request object with classId, examId, subjectName query params
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const getClassMarks = async (req, res, next) => {
  try {
    const { classId, examId, subjectName } = classMarksQuerySchema.parse(req.query);
    const madrasaId = req.user.madrasaId;
    const record = await examService.getClassMarks(madrasaId, classId, examId, subjectName);
    if (!record) {
      return res.status(200).json({ success: true, message: 'No exam marks records found for class subject.', data: { madrasaId, classId, examId, subjectName, maxMarks: 100, records: [] } });
    }
    res.status(200).json({ success: true, data: record });
  } catch (error) {
    catchError(error, res, next);
  }
};

/**
 * Generate a report card with all exam scores for a student
 * @param {import('express').Request} req - Express request object with studentId param
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const getStudentReportCard = async (req, res, next) => {
  try {
    const { studentId } = req.params;
    const madrasaId = req.user.madrasaId;
    const result = await examService.getStudentReportCard(studentId, madrasaId);
    res.status(200).json({ success: true, data: result });
  } catch (error) {
    catchError(error, res, next);
  }
};

module.exports = { submitMarks, getClassMarks, getStudentReportCard };
