const express = require('express');
const {
  submitMarks,
  getClassMarks,
  getStudentReportCard,
} = require('../controllers/examController');
const { requireAuth, requirePermission } = require('../middleware/auth');

const router = express.Router();

// Apply auth middleware to protect all exam endpoints
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
 * /api/v1/exams:
 *   post:
 *     tags: [Exams]
 *     summary: Submit or update exam marks for a class subject
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [classId, examId, subjectName, records]
 *             properties:
 *               classId:
 *                 type: string
 *                 description: MongoDB ObjectId of the class
 *               examId:
 *                 type: string
 *                 description: MongoDB ObjectId of the exam
 *               subjectName:
 *                 type: string
 *               maxMarks:
 *                 type: number
 *                 default: 100
 *               records:
 *                 type: array
 *                 items:
 *                   type: object
 *                   required: [studentId, marksObtained]
 *                   properties:
 *                     studentId:
 *                       type: string
 *                       description: MongoDB ObjectId of the student
 *                     marksObtained:
 *                       type: number
 *                       minimum: 0
 *                     remarks:
 *                       type: string
 *     responses:
 *       200:
 *         description: Exam marks recorded successfully
 *       400:
 *         description: Validation error
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ValidationError'
 */

router.post('/', requirePermission('exams:write'), submitMarks);
/**
 * @swagger
 * /api/v1/exams/class:
 *   get:
 *     tags: [Exams]
 *     summary: Retrieve marks for a class, exam, and subject combination
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
 *         name: examId
 *         required: true
 *         schema:
 *           type: string
 *         description: MongoDB ObjectId of the exam
 *       - in: query
 *         name: subjectName
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Exam marks data for the class subject
 *       400:
 *         description: Invalid query parameters
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ValidationError'
 */

router.get('/', requirePermission('exams:read'), getClassMarks);
/**
 * @swagger
 * /api/v1/exams/report/{studentId}:
 *   get:
 *     tags: [Exams]
 *     summary: Generate a report card with all exam scores for a student
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: studentId
 *         required: true
 *         schema:
 *           type: string
 *         description: MongoDB ObjectId of the student
 *     responses:
 *       200:
 *         description: Student report card data
 *       404:
 *         description: Student not found
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ErrorResponse'
 */

router.get('/report/:studentId', requirePermission('exams:read'), getStudentReportCard);

module.exports = router;
