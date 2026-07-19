const { z } = require('zod');
const mongoose = require('mongoose');
const ExamRecord = require('../models/ExamRecord');
const Student = require('../models/Student');

// Payload validation schemas
const scoreInputSchema = z.object({
  studentId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Student ID format'),
  marksObtained: z.number().min(0),
  remarks: z.string().trim().optional(),
});

const submitMarksSchema = z.object({
  classId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Class ID format'),
  examId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Exam ID format'),
  subjectName: z.string().trim().min(1),
  maxMarks: z.number().min(1).default(100),
  records: z.array(scoreInputSchema).min(1, 'Marks entry list cannot be empty'),
});

const classMarksQuerySchema = z.object({
  classId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Class ID format'),
  examId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Exam ID format'),
  subjectName: z.string().trim().min(1),
});

/**
 * Submit or update exam marks for a class
 */
const submitMarks = async (req, res, next) => {
  try {
    const { classId, examId, subjectName, maxMarks, records } = submitMarksSchema.parse(req.body);
    const madrasaId = req.user.madrasaId;

    // Verify all marksObtained are less than or equal to maxMarks
    const invalidRecord = records.find(rec => rec.marksObtained > maxMarks);
    if (invalidRecord) {
      return res.status(400).json({
        success: false,
        error: {
          code: 'INVALID_MARKS',
          message: `Marks obtained cannot exceed max marks value: ${maxMarks}`,
        },
      });
    }

    // Find the exam record bucket or initialize it
    let record = await ExamRecord.findOne({ madrasaId, classId, examId, subjectName });

    if (!record) {
      record = new ExamRecord({
        madrasaId,
        classId,
        examId,
        subjectName,
        maxMarks,
        records: [],
      });
    } else {
      record.maxMarks = maxMarks; // Update in case maxMarks changed
    }

    // Map student records
    record.records = records.map(rec => ({
      studentId: new mongoose.Types.ObjectId(rec.studentId),
      marksObtained: rec.marksObtained,
      remarks: rec.remarks,
    }));

    await record.save();

    res.status(200).json({
      success: true,
      message: 'Exam marks successfully recorded.',
      data: record,
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
 * Fetch marks sheet for a class
 */
const getClassMarks = async (req, res, next) => {
  try {
    const { classId, examId, subjectName } = classMarksQuerySchema.parse(req.query);
    const madrasaId = req.user.madrasaId;

    const record = await ExamRecord.findOne({ madrasaId, classId, examId, subjectName })
      .populate('records.studentId', 'firstName lastName admissionNo rollNo');

    if (!record) {
      return res.status(200).json({
        success: true,
        message: 'No exam marks records found for class subject.',
        data: {
          madrasaId,
          classId,
          examId,
          subjectName,
          maxMarks: 100,
          records: [],
        },
      });
    }

    res.status(200).json({
      success: true,
      data: record,
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
 * Aggregate student report card across exams
 */
const getStudentReportCard = async (req, res, next) => {
  try {
    const { studentId } = req.params;
    const madrasaId = req.user.madrasaId;

    // Verify student exists
    const student = await Student.findOne({ _id: studentId, madrasaId, isDeleted: false });
    if (!student) {
      return res.status(404).json({
        success: false,
        error: {
          code: 'STUDENT_NOT_FOUND',
          message: 'Student profile not found or belongs to another tenant.',
        },
      });
    }

    // Fetch all exam records matching this student ID
    const examRecords = await ExamRecord.find({
      madrasaId,
      'records.studentId': new mongoose.Types.ObjectId(studentId),
    });

    // Aggregate reports subject-by-subject
    const reports = examRecords.map(record => {
      const studentScore = record.records.find(
        rec => rec.studentId.toString() === studentId
      );

      const percentage = record.maxMarks > 0 
        ? Math.round((studentScore.marksObtained / record.maxMarks) * 100) 
        : 0;

      return {
        examId: record.examId,
        subjectName: record.subjectName,
        maxMarks: record.maxMarks,
        marksObtained: studentScore.marksObtained,
        percentage,
        remarks: studentScore.remarks,
      };
    });

    res.status(200).json({
      success: true,
      data: {
        student: {
          id: student._id,
          firstName: student.firstName,
          lastName: student.lastName,
          admissionNo: student.admissionNo,
          rollNo: student.rollNo,
        },
        scores: reports,
      },
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  submitMarks,
  getClassMarks,
  getStudentReportCard,
};
