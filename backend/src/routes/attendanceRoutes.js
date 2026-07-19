const express = require('express');
const {
  submitAttendance,
  getMonthlySheet,
  getAttendanceSummary,
} = require('../controllers/attendanceController');
const { requireAuth, requirePermission } = require('../middleware/auth');

const router = express.Router();

// Apply auth middleware to protect all attendance routes
router.use(requireAuth);

// Attendance Grid Submission & Sheet retrieval
router.post('/', requirePermission('attendance:write'), submitAttendance);
router.get('/sheet', requirePermission('attendance:read'), getMonthlySheet);
router.get('/summary', requirePermission('attendance:read'), getAttendanceSummary);

module.exports = router;
