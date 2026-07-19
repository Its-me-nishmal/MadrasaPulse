const express = require('express');
const {
  createTeacher,
  getTeachers,
  getTeacherById,
  updateTeacher,
  deleteTeacher,
} = require('../controllers/teacherController');
const { requireAuth, requirePermission } = require('../middleware/auth');

const router = express.Router();

// Apply auth middleware to protect all teacher routes
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
 * /api/v1/teachers:
 *   post:
 *     tags: [Teachers]
 *     summary: Create a new teacher record
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [staffId, firstName, lastName, phone]
 *             properties:
 *               staffId:
 *                 type: string
 *               firstName:
 *                 type: string
 *               lastName:
 *                 type: string
 *               phone:
 *                 type: string
 *               email:
 *                 type: string
 *               qualifications:
 *                 type: array
 *                 items:
 *                   type: string
 *               assignedClasses:
 *                 type: array
 *                 items:
 *                   type: object
 *                   properties:
 *                     classId:
 *                       type: string
 *                       description: MongoDB ObjectId of the class
 *                     subjectName:
 *                       type: string
 *     responses:
 *       201:
 *         description: Teacher created successfully
 *       400:
 *         description: Validation error
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ValidationError'
 */

router.post('/', requirePermission('teachers:write'), createTeacher);
/**
 * @swagger
 * /api/v1/teachers:
 *   get:
 *     tags: [Teachers]
 *     summary: Retrieve a paginated list of teachers with optional filtering
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *       - in: query
 *         name: limit
 *         schema:
 *           type: integer
 *       - in: query
 *         name: search
 *         schema:
 *           type: string
 *         description: Search by name
 *     responses:
 *       200:
 *         description: Paginated list of teachers with meta
 */
router.get('/', requirePermission('teachers:read'), getTeachers);

/**
 * @swagger
 * /api/v1/teachers/{id}:
 *   get:
 *     tags: [Teachers]
 *     summary: Get a single teacher by ID
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: MongoDB ObjectId of the teacher
 *     responses:
 *       200:
 *         description: Teacher data
 *       404:
 *         description: Teacher not found
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ErrorResponse'
 */

router.get('/:id', requirePermission('teachers:read'), getTeacherById);
/**
 * @swagger
 * /api/v1/teachers/{id}:
 *   put:
 *     tags: [Teachers]
 *     summary: Update an existing teacher record
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: MongoDB ObjectId of the teacher
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               staffId:
 *                 type: string
 *               firstName:
 *                 type: string
 *               lastName:
 *                 type: string
 *               phone:
 *                 type: string
 *               email:
 *                 type: string
 *               qualifications:
 *                 type: array
 *                 items:
 *                   type: string
 *               assignedClasses:
 *                 type: array
 *                 items:
 *                   type: object
 *                   properties:
 *                     classId:
 *                       type: string
 *                     subjectName:
 *                       type: string
 *     responses:
 *       200:
 *         description: Teacher updated successfully
 *       400:
 *         description: Validation error
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ValidationError'
 *       404:
 *         description: Teacher not found
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ErrorResponse'
 */

router.put('/:id', requirePermission('teachers:write'), updateTeacher);
/**
 * @swagger
 * /api/v1/teachers/{id}:
 *   delete:
 *     tags: [Teachers]
 *     summary: Soft-delete (archive) a teacher record
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: MongoDB ObjectId of the teacher
 *     responses:
 *       200:
 *         description: Teacher archived successfully
 *       404:
 *         description: Teacher not found
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ErrorResponse'
 */

router.delete('/:id', requirePermission('teachers:delete'), deleteTeacher);

module.exports = router;
