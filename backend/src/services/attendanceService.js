const mongoose = require('mongoose');
const Attendance = require('../models/Attendance');

/**
 * Submit or update attendance records for a specific day and class
 * @param {String} classId - The class MongoDB ObjectId
 * @param {String} monthYear - The month-year key in YYYY-MM format
 * @param {Number} day - The day of the month (1-31)
 * @param {String} submittedBy - The submitting user's ID
 * @param {Object[]} records - Array of attendance records with studentId, status, and optional note
 * @param {String} madrasaId - The madrasa tenant ID
 * @returns {Promise<Object>} The updated attendance bucket document
 */
const submitAttendance = async (classId, monthYear, day, submittedBy, records, madrasaId) => {
  let bucket = await Attendance.findOne({ madrasaId, classId, monthYear });
  if (!bucket) {
    bucket = new Attendance({
      madrasaId,
      classId,
      monthYear,
      dailyLogs: [],
    });
  }
  const existingLogIndex = bucket.dailyLogs.findIndex((log) => log.day === day);
  const logPayload = {
    day,
    submittedBy,
    records: records.map(rec => ({
      studentId: new mongoose.Types.ObjectId(rec.studentId),
      status: rec.status,
      note: rec.note,
    })),
  };
  if (existingLogIndex > -1) {
    bucket.dailyLogs[existingLogIndex] = logPayload;
  } else {
    bucket.dailyLogs.push(logPayload);
  }
  bucket.dailyLogs.sort((a, b) => a.day - b.day);
  await bucket.save();
  return bucket;
};

/**
 * Retrieve the full monthly attendance sheet for a class
 * @param {String} madrasaId - The madrasa tenant ID
 * @param {String} classId - The class MongoDB ObjectId
 * @param {String} monthYear - The month-year key in YYYY-MM format
 * @returns {Promise<Object|null>} The attendance bucket document with populated student data
 */
const getMonthlySheet = async (madrasaId, classId, monthYear) => {
  const sheet = await Attendance.findOne({ madrasaId, classId, monthYear })
    .populate('dailyLogs.records.studentId', 'firstName lastName admissionNo rollNo');
  return sheet;
};

/**
 * Compute attendance summary statistics (totals and rates) for a class and month
 * @param {String} madrasaId - The madrasa tenant ID
 * @param {String} classId - The class MongoDB ObjectId
 * @param {String} monthYear - The month-year key in YYYY-MM format
 * @returns {Promise<{totalDaysLogged: Number, attendanceRate: Number, counts: {Present: Number, Absent: Number, Late: Number, Excused: Number}}>}
 */
const getAttendanceSummary = async (madrasaId, classId, monthYear) => {
  const sheet = await Attendance.findOne({ madrasaId, classId, monthYear });
  if (!sheet || !sheet.dailyLogs.length) {
    return { totalDaysLogged: 0, attendanceRate: 100, counts: { Present: 0, Absent: 0, Late: 0, Excused: 0 } };
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
  return { totalDaysLogged: sheet.dailyLogs.length, attendanceRate, counts: { Present: present, Absent: absent, Late: late, Excused: excused } };
};

module.exports = { submitAttendance, getMonthlySheet, getAttendanceSummary };
