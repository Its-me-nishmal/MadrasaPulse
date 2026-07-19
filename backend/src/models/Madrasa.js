const mongoose = require('mongoose');

const MadrasaSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
      trim: true,
    },
    domain: {
      type: String,
      unique: true,
      trim: true,
      lowercase: true,
    },
    contactInfo: {
      phone: {
        type: String,
      },
      email: {
        type: String,
        trim: true,
        lowercase: true,
      },
    },
    enabledModules: {
      type: [String],
      default: ['students', 'teachers', 'attendance'], // Basic starter modules enabled by default
    },
    subscription: {
      plan: {
        type: String,
        required: true,
        enum: ['Basic', 'Standard', 'Premium'],
        default: 'Basic',
      },
      expiresAt: {
        type: Date,
      },
    },
  },
  {
    timestamps: true,
  }
);

MadrasaSchema.index({ domain: 1 });
MadrasaSchema.index({ 'subscription.plan': 1, 'subscription.expiresAt': 1 });

module.exports = mongoose.model('Madrasa', MadrasaSchema);
