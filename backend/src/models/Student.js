const mongoose = require('mongoose');

const GuardianSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  relationship: {
    type: String,
    required: true,
    enum: ['Father', 'Mother', 'Grandfather', 'Grandmother', 'Uncle', 'Aunt', 'Brother', 'Sister', 'Guardian'],
  },
  phone: {
    type: String,
    required: true,
    trim: true,
  },
  isPrimary: {
    type: Boolean,
    default: false,
  },
});

const StudentSchema = new mongoose.Schema(
  {
    madrasaId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Madrasa',
      required: true,
    },
    admissionNo: {
      type: String,
      required: true,
      trim: true,
    },
    rollNo: {
      type: String,
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
    dateOfBirth: {
      type: Date,
      required: true,
    },
    classId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Class',
    },
    guardians: {
      type: [GuardianSchema],
      validate: [
        (arr) => arr.length > 0,
        'At least one guardian contact profile is required.'
      ],
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

// Compound Unique Index: Enforce unique admission number within each madrasa tenant
StudentSchema.index({ madrasaId: 1, admissionNo: 1 }, { unique: true });

// Compound Index: Optimize student lookups per class context
StudentSchema.index({ madrasaId: 1, classId: 1, isDeleted: 1 });

// Text Index: Optimize global keyword search for name fields
StudentSchema.index({ firstName: 'text', lastName: 'text' });
StudentSchema.index({ madrasaId: 1, isDeleted: 1 });
StudentSchema.index({ classId: 1, isDeleted: 1 });
StudentSchema.index({ madrasaId: 1, classId: 1, admissionNo: 1 });

module.exports = mongoose.model('Student', StudentSchema);
