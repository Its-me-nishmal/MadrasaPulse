const { submitAttendanceSchema, monthlySheetQuerySchema } = require('../validators/attendanceValidator');
const attendanceService = require('../services/attendanceService');
const { catchError } = require('../utils/errorHandler');

/**
 * Submit or update daily attendance records for a class
 * @param {import('express').Request} req - Express request object with validated attendance data
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const submitAttendance = async (req, res, next) => {
  try {
    const { classId, date, records } = submitAttendanceSchema.parse(req.body);
    const madrasaId = req.user.madrasaId;
    const userId = req.user.userId;
    const parsedDate = new Date(date);
    const year = parsedDate.getFullYear();
    const month = String(parsedDate.getMonth() + 1).padStart(2, '0');
    const monthYear = `${year}-${month}`;
    const day = parsedDate.getDate();
    const bucket = await attendanceService.submitAttendance(classId, monthYear, day, userId, records, madrasaId);
    res.status(200).json({ success: true, message: `Attendance log successfully submitted for ${date}.`, data: bucket });
  } catch (error) {
    catchError(error, res, next);
  }
};

/**
 * Retrieve the monthly attendance sheet for a class
 * @param {import('express').Request} req - Express request object with classId and monthYear query params
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const getMonthlySheet = async (req, res, next) => {
  try {
    const { classId, monthYear } = monthlySheetQuerySchema.parse(req.query);
    const madrasaId = req.user.madrasaId;
    const sheet = await attendanceService.getMonthlySheet(madrasaId, classId, monthYear);
    if (!sheet) {
      return res.status(200).json({ success: true, message: `No attendance records found for class on ${monthYear}.`, data: { madrasaId, classId, monthYear, dailyLogs: [] } });
    }
    res.status(200).json({ success: true, data: sheet });
  } catch (error) {
    catchError(error, res, next);
  }
};

/**
 * Get attendance summary statistics for a class in a given month
 * @param {import('express').Request} req - Express request object with classId and monthYear query params
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next middleware function
 * @returns {Promise<void>}
 */
const getAttendanceSummary = async (req, res, next) => {
  try {
    const { classId, monthYear } = monthlySheetQuerySchema.parse(req.query);
    const madrasaId = req.user.madrasaId;
    const summary = await attendanceService.getAttendanceSummary(madrasaId, classId, monthYear);
    res.status(200).json({ success: true, data: summary });
  } catch (error) {
    catchError(error, res, next);
  }
};

module.exports = { submitAttendance, getMonthlySheet, getAttendanceSummary };
