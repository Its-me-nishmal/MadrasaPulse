const mongoose = require('mongoose');
const ExamRecord = require('../models/ExamRecord');

/**
 * Submit or update exam marks for a class, exam, and subject combination
 * @param {String} madrasaId - The madrasa tenant ID
 * @param {Object} data - Marks payload with classId, examId, subjectName, maxMarks, records
 * @returns {Promise<Object>} The updated exam record document
 */
const submitMarks = async (madrasaId, data) => {
  const { classId, examId, subjectName, maxMarks, records } = data;
  const invalidRecord = records.find(rec => rec.marksObtained > (maxMarks || 100));
  if (invalidRecord) {
    const error = new Error(`Marks obtained cannot exceed max marks value: ${maxMarks || 100}`);
    error.statusCode = 400;
    error.code = 'INVALID_MARKS';
    throw error;
  }
  let record = await ExamRecord.findOne({ madrasaId, classId, examId, subjectName });
  if (!record) {
    record = new ExamRecord({
      madrasaId,
      classId,
      examId,
      subjectName,
      maxMarks: maxMarks || 100,
      records: [],
    });
  } else {
    record.maxMarks = maxMarks || 100;
  }
  record.records = records.map(rec => ({
    studentId: new mongoose.Types.ObjectId(rec.studentId),
    marksObtained: rec.marksObtained,
    remarks: rec.remarks,
  }));
  await record.save();
  return record;
};

/**
 * Retrieve exam marks for a class, exam, and subject
 * @param {String} madrasaId - The madrasa tenant ID
 * @param {String} classId - The class MongoDB ObjectId
 * @param {String} examId - The exam MongoDB ObjectId
 * @param {String} subjectName - The subject name
 * @returns {Promise<Object|null>} The exam record document with populated student data
 */
const getClassMarks = async (madrasaId, classId, examId, subjectName) => {
  const record = await ExamRecord.findOne({ madrasaId, classId, examId, subjectName })
    .populate('records.studentId', 'firstName lastName admissionNo rollNo');
  return record;
};

/**
 * Generate a report card with all exam scores across subjects for a student
 * @param {String} studentId - The student's MongoDB ObjectId
 * @param {String} madrasaId - The madrasa tenant ID
 * @returns {Promise<{student: Object, scores: Object[]}>}
 */
const getStudentReportCard = async (studentId, madrasaId) => {
  const Student = require('../models/Student');
  const student = await Student.findOne({ _id: studentId, madrasaId, isDeleted: false });
  if (!student) {
    const error = new Error('Student profile not found or belongs to another tenant.');
    error.statusCode = 404;
    error.code = 'STUDENT_NOT_FOUND';
    throw error;
  }
  const examRecords = await ExamRecord.find({
    madrasaId,
    'records.studentId': new mongoose.Types.ObjectId(studentId),
  });
  const reports = examRecords.map(record => {
    const studentScore = record.records.find(rec => rec.studentId.toString() === studentId);
    const percentage = record.maxMarks > 0 ? Math.round((studentScore.marksObtained / record.maxMarks) * 100) : 0;
    return {
      examId: record.examId,
      subjectName: record.subjectName,
      maxMarks: record.maxMarks,
      marksObtained: studentScore.marksObtained,
      percentage,
      remarks: studentScore.remarks,
    };
  });
  return {
    student: {
      id: student._id,
      firstName: student.firstName,
      lastName: student.lastName,
      admissionNo: student.admissionNo,
      rollNo: student.rollNo,
    },
    scores: reports,
  };
};

module.exports = { submitMarks, getClassMarks, getStudentReportCard };
