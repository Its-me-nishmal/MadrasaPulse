const mongoose = require('mongoose');

const StudentScoreSchema = new mongoose.Schema({
  studentId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Student',
    required: true,
  },
  marksObtained: {
    type: Number,
    required: true,
    min: 0,
  },
  remarks: {
    type: String,
    trim: true,
  },
});

const ExamRecordSchema = new mongoose.Schema(
  {
    madrasaId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Madrasa',
      required: true,
    },
    classId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Class',
      required: true,
    },
    examId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Exam', // Assuming Exam metadata exists (e.g. Midterm, Final)
      required: true,
    },
    subjectName: {
      type: String,
      required: true,
      trim: true,
    },
    maxMarks: {
      type: Number,
      required: true,
      default: 100,
      min: 1,
    },
    records: {
      type: [StudentScoreSchema],
      validate: [
        (arr) => arr.length > 0,
        'Exam records list cannot be empty.'
      ],
    },
  },
  {
    timestamps: true,
  }
);

// Compound Unique Index: Exactly one exam bucket per class per exam event per subject
ExamRecordSchema.index({ madrasaId: 1, classId: 1, examId: 1, subjectName: 1 }, { unique: true });

// Optimize lookups by individual student across exam buckets
ExamRecordSchema.index({ 'records.studentId': 1 });

module.exports = mongoose.model('ExamRecord', ExamRecordSchema);
