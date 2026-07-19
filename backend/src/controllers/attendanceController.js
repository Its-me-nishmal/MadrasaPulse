const { z } = require('zod');
const mongoose = require('mongoose');
const Attendance = require('../models/Attendance');

// Validation schemas
const attendanceRecordInput = z.object({
  studentId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Student ID format'),
  status: z.enum(['Present', 'Absent', 'Late', 'Excused']),
  note: z.string().trim().optional(),
});

const submitAttendanceSchema = z.object({
  classId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Class ID format'),
  date: z.string().regex(/^\d{4}-\d{2}-\d{2}$/, 'Date must be in YYYY-MM-DD format'),
  records: z.array(attendanceRecordInput).min(1, 'Attendance list cannot be empty'),
});

const monthlySheetQuerySchema = z.object({
  classId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Class ID format'),
  monthYear: z.string().regex(/^\d{4}-\d{2}$/, 'Month must be in YYYY-MM format'),
});

/**
 * Submit or update daily attendance logs
 */
const submitAttendance = async (req, res, next) => {
  try {
    const { classId, date, records } = submitAttendanceSchema.parse(req.body);
    const madrasaId = req.user.madrasaId; // Tenant context
    const userId = req.user.userId; // Submitting admin/teacher

    // Parse the date into YYYY-MM and day
    const parsedDate = new Date(date);
    const year = parsedDate.getFullYear();
    const month = String(parsedDate.getMonth() + 1).padStart(2, '0');
    const monthYear = `${year}-${month}`;
    const day = parsedDate.getDate();

    // Find the monthly attendance bucket or create it
    let bucket = await Attendance.findOne({ madrasaId, classId, monthYear });

    if (!bucket) {
      bucket = new Attendance({
        madrasaId,
        classId,
        monthYear,
        dailyLogs: [],
      });
    }

    // Check if daily log already exists for this day index
    const existingLogIndex = bucket.dailyLogs.findIndex((log) => log.day === day);

    const logPayload = {
      day,
      submittedBy: userId,
      records: records.map(rec => ({
        studentId: new mongoose.Types.ObjectId(rec.studentId),
        status: rec.status,
        note: rec.note,
      })),
    };

    if (existingLogIndex > -1) {
      // Overwrite/update existing day's attendance
      bucket.dailyLogs[existingLogIndex] = logPayload;
    } else {
      // Append new day's attendance
      bucket.dailyLogs.push(logPayload);
    }

    // Sort dailyLogs by day ascending to maintain order
    bucket.dailyLogs.sort((a, b) => a.day - b.day);

    await bucket.save();

    res.status(200).json({
      success: true,
      message: `Attendance log successfully submitted for ${date}.`,
      data: bucket,
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
 * Fetch monthly attendance sheet for a class
 */
const getMonthlySheet = async (req, res, next) => {
  try {
    const { classId, monthYear } = monthlySheetQuerySchema.parse(req.query);
    const madrasaId = req.user.madrasaId;

    const sheet = await Attendance.findOne({ madrasaId, classId, monthYear })
      .populate('dailyLogs.records.studentId', 'firstName lastName admissionNo rollNo');

    if (!sheet) {
      return res.status(200).json({
        success: true,
        message: `No attendance records found for class on ${monthYear}.`,
        data: {
          madrasaId,
          classId,
          monthYear,
          dailyLogs: [],
        },
      });
    }

    res.status(200).json({
      success: true,
      data: sheet,
    });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({
        success: false,
        error: {
          code: 'VALIDATION_FAILED',
          message: 'Invalid query parameters.',
          details: error.errors.map(err => ({ field: err.path.join('.'), issue: err.message })),
        },
      });
    }
    next(error);
  }
};

/**
 * Retrieve statistical summary for a monthly class bucket
 */
const getAttendanceSummary = async (req, res, next) => {
  try {
    const { classId, monthYear } = monthlySheetQuerySchema.parse(req.query);
    const madrasaId = req.user.madrasaId;

    const sheet = await Attendance.findOne({ madrasaId, classId, monthYear });

    if (!sheet || sheet.dailyLogs.length === 0) {
      return res.status(200).json({
        success: true,
        data: {
          totalDaysLogged: 0,
          attendanceRate: 100, // Default to 100% if no logs exist
          counts: { Present: 0, Absent: 0, Late: 0, Excused: 0 },
        },
      });
    }

    let present = 0;
    let absent = 0;
    let late = 0;
    let excused = 0;

    sheet.dailyLogs.forEach((log) => {
      log.records.forEach((record) => {
        if (record.status === 'Present') present++;
        else if (record.status === 'Absent') absent++;
        else if (record.status === 'Late') late++;
        else if (record.status === 'Excused') excused++;
      });
    });

    const totalRecords = present + absent + late + excused;
    const attendanceRate = totalRecords > 0 ? Math.round(((present + late) / totalRecords) * 100) : 100;

    res.status(200).json({
      success: true,
      data: {
        totalDaysLogged: sheet.dailyLogs.length,
        attendanceRate,
        counts: {
          Present: present,
          Absent: absent,
          Late: late,
          Excused: excused,
        },
      },
    });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({
        success: false,
        error: {
          code: 'VALIDATION_FAILED',
          message: 'Invalid query parameters.',
        },
      });
    }
    next(error);
  }
};

module.exports = {
  submitAttendance,
  getMonthlySheet,
  getAttendanceSummary,
};
