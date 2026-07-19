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

/**
 * @swagger
 * components:
 *   schemas:
 *     ErrorResponse:
 *       type: object
 *       properties:
 *         success:
 *           type: boolean
 *           example: false
 *         message:
 *           type: string
 *           example: "Error message"
 *     ValidationError:
 *       type: object
 *       properties:
 *         success:
 *           type: boolean
 *           example: false
 *         message:
 *           type: string
 *           example: "Validation failed"
 *         errors:
 *           type: array
 *           items:
 *             type: object
 *             properties:
 *               field:
 *                 type: string
 *               message:
 *                 type: string
 */

/**
 * @swagger
 * /api/v1/attendance:
 *   post:
 *     tags: [Attendance]
 *     summary: Submit or update daily attendance records for a class
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [classId, date, records]
 *             properties:
 *               classId:
 *                 type: string
 *                 description: MongoDB ObjectId of the class
 *               date:
 *                 type: string
 *                 format: date
 *                 description: Date in YYYY-MM-DD format
 *               records:
 *                 type: array
 *                 items:
 *                   type: object
 *                   required: [studentId, status]
 *                   properties:
 *                     studentId:
 *                       type: string
 *                       description: MongoDB ObjectId of the student
 *                     status:
 *                       type: string
 *                       enum: [Present, Absent, Late, Excused]
 *                     note:
 *                       type: string
 *     responses:
 *       200:
 *         description: Attendance submitted successfully
 *       400:
 *         description: Validation error
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ValidationError'
 */

router.post('/', requirePermission('attendance:write'), submitAttendance);
/**
 * @swagger
 * /api/v1/attendance/sheet:
 *   get:
 *     tags: [Attendance]
 *     summary: Retrieve the monthly attendance sheet for a class
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: classId
 *         required: true
 *         schema:
 *           type: string
 *         description: MongoDB ObjectId of the class
 *       - in: query
 *         name: monthYear
 *         required: true
 *         schema:
 *           type: string
 *           pattern: '^\d{4}-\d{2}$'
 *         description: Month in YYYY-MM format
 *     responses:
 *       200:
 *         description: Monthly attendance sheet data
 *       400:
 *         description: Invalid query parameters
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ValidationError'
 */

router.get('/sheet', requirePermission('attendance:read'), getMonthlySheet);
/**
 * @swagger
 * /api/v1/attendance/summary:
 *   get:
 *     tags: [Attendance]
 *     summary: Get attendance summary statistics for a class in a given month
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: classId
 *         required: true
 *         schema:
 *           type: string
 *         description: MongoDB ObjectId of the class
 *       - in: query
 *         name: monthYear
 *         required: true
 *         schema:
 *           type: string
 *           pattern: '^\d{4}-\d{2}$'
 *         description: Month in YYYY-MM format
 *     responses:
 *       200:
 *         description: Attendance summary statistics
 *       400:
 *         description: Invalid query parameters
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ValidationError'
 */

router.get('/summary', requirePermission('attendance:read'), getAttendanceSummary);

module.exports = router;
