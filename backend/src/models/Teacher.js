const mongoose = require('mongoose');

const TeacherAssignmentSchema = new mongoose.Schema({
  classId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Class',
    required: true,
  },
  subjectName: {
    type: String,
    required: true,
    trim: true,
  },
});

const TeacherSchema = new mongoose.Schema(
  {
    madrasaId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Madrasa',
      required: true,
    },
    staffId: {
      type: String,
      required: true,
      trim: true,
    },
    firstName: {
      type: String,
      required: true,
      trim: true,
    },
    lastName: {
      type: String,
      required: true,
      trim: true,
    },
    phone: {
      type: String,
      required: true,
      trim: true,
    },
    email: {
      type: String,
      trim: true,
      lowercase: true,
    },
    qualifications: {
      type: [String],
      default: [],
    },
    assignedClasses: {
      type: [TeacherAssignmentSchema],
      default: [],
    },
    isDeleted: {
      type: Boolean,
      default: false,
      index: true,
    },
  },
  {
    timestamps: true,
  }
);

// Compound Unique Index: Enforce unique staff/teacher ID per madrasa
TeacherSchema.index({ madrasaId: 1, staffId: 1 }, { unique: true });

// Compound Index: Optimize teacher filtering by tenant context
TeacherSchema.index({ madrasaId: 1, isDeleted: 1 });

// Text Index: Optimize global keyword search for teacher names
TeacherSchema.index({ firstName: 'text', lastName: 'text' });
TeacherSchema.index({ madrasaId: 1, 'assignedClasses.classId': 1 });
TeacherSchema.index({ 'assignedClasses.subjectName': 1 });

module.exports = mongoose.model('Teacher', TeacherSchema);
