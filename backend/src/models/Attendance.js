const mongoose = require('mongoose');

const AttendanceRecordSchema = new mongoose.Schema({
  studentId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Student',
    required: true,
  },
  status: {
    type: String,
    required: true,
    enum: ['Present', 'Absent', 'Late', 'Excused'],
    default: 'Present',
  },
  note: {
    type: String,
    trim: true,
  },
});

const DailyLogSchema = new mongoose.Schema({
  day: {
    type: Number,
    required: true,
    min: 1,
    max: 31,
  },
  submittedBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
  },
  records: {
    type: [AttendanceRecordSchema],
    validate: [
      (arr) => arr.length > 0,
      'Daily attendance records list cannot be empty.'
    ],
  },
});

const AttendanceBucketSchema = new mongoose.Schema(
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
    monthYear: {
      type: String,
      required: true,
      validate: {
        validator: (v) => /^\d{4}-\d{2}$/.test(v),
        message: (props) => `${props.value} is not a valid YYYY-MM month format.`
      },
    },
    dailyLogs: {
      type: [DailyLogSchema],
      default: [],
    },
  },
  {
    timestamps: true,
  }
);

// Compound Unique Index: Enforce exactly one bucket document per class per month
AttendanceBucketSchema.index({ madrasaId: 1, classId: 1, monthYear: 1 }, { unique: true });

// Compound Index: Optimize student lookup queries inside class buckets
AttendanceBucketSchema.index({ 'dailyLogs.records.studentId': 1, monthYear: 1 });

module.exports = mongoose.model('Attendance', AttendanceBucketSchema);
