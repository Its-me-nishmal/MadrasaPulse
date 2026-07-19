const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const UserSchema = new mongoose.Schema(
  {
    madrasaId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Madrasa',
      required: true,
    },
    username: {
      type: String,
      required: true,
      trim: true,
      lowercase: true,
    },
    passwordHash: {
      type: String,
      required: true,
    },
    role: {
      type: String,
      required: true,
      enum: ['SuperAdmin', 'MadrasaAdmin', 'Teacher', 'Parent', 'Student'],
    },
    linkedEntityId: {
      type: mongoose.Schema.Types.ObjectId,
      refPath: 'role', // Dynamic reference path if needed, e.g. resolves to Student or Teacher
    },
    isActive: {
      type: Boolean,
      default: true,
    },
  },
  {
    timestamps: true,
  }
);

// Enforce unique usernames per madrasa tenant
UserSchema.index({ madrasaId: 1, username: 1 }, { unique: true });
UserSchema.index({ madrasaId: 1, role: 1 });
UserSchema.index({ isActive: 1 });

// Pre-save password hashing hook
UserSchema.pre('save', async function (next) {
  const user = this;
  if (!user.isModified('passwordHash')) return next();

  try {
    const salt = await bcrypt.genSalt(10);
    user.passwordHash = await bcrypt.hash(user.passwordHash, salt);
    next();
  } catch (error) {
    next(error);
  }
});

// Helper instance method to compare passwords
UserSchema.methods.comparePassword = async function (candidatePassword) {
  return bcrypt.compare(candidatePassword, this.passwordHash);
};

module.exports = mongoose.model('User', UserSchema);
