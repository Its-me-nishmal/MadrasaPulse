const mongoose = require('mongoose');

const DeviceTokenSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true,
      index: true,
    },
    token: {
      type: String,
      required: true,
      unique: true,
      trim: true,
    },
    platform: {
      type: String,
      required: true,
      enum: ['android', 'ios'],
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model('DeviceToken', DeviceTokenSchema);
