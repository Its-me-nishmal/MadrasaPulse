const express = require('express');
const {
  createStudent,
  getStudents,
  getStudentById,
  updateStudent,
  deleteStudent,
  promoteStudents,
} = require('../controllers/studentController');
const { requireAuth, requirePermission } = require('../middleware/auth');

const router = express.Router();

// Apply auth middleware to protect all student routes
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
 * /api/v1/students:
 *   post:
 *     tags: [Students]
 *     summary: Create a new student record
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [admissionNo, firstName, lastName, dateOfBirth, guardians]
 *             properties:
 *               admissionNo:
 *                 type: string
 *               rollNo:
 *                 type: string
 *               firstName:
 *                 type: string
 *               lastName:
 *                 type: string
 *               dateOfBirth:
 *                 type: string
 *                 format: date
 *               classId:
 *                 type: string
 *                 description: MongoDB ObjectId of the class
 *               guardians:
 *                 type: array
 *                 items:
 *                   type: object
 *                   required: [name, relationship, phone]
 *                   properties:
 *                     name:
 *                       type: string
 *                     relationship:
 *                       type: string
 *                       enum: [Father, Mother, Grandfather, Grandmother, Uncle, Aunt, Brother, Sister, Guardian]
 *                     phone:
 *                       type: string
 *                     isPrimary:
 *                       type: boolean
 *     responses:
 *       201:
 *         description: Student created successfully
 *       400:
 *         description: Validation error
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ValidationError'
 */

router.post('/', requirePermission('students:write'), createStudent);
/**
 * @swagger
 * /api/v1/students:
 *   get:
 *     tags: [Students]
 *     summary: Retrieve a paginated list of students with optional filtering
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
 *         name: classId
 *         schema:
 *           type: string
 *         description: Filter by class ObjectId
 *       - in: query
 *         name: search
 *         schema:
 *           type: string
 *         description: Search by name
 *     responses:
 *       200:
 *         description: Paginated list of students with meta
 */
router.get('/', requirePermission('students:read'), getStudents);
/**
 * @swagger
 * /api/v1/students/promote:
 *   post:
 *     tags: [Students]
 *     summary: Promote students to a target class
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [studentIds, targetClassId]
 *             properties:
 *               studentIds:
 *                 type: array
 *                 items:
 *                   type: string
 *                   description: MongoDB ObjectId of the student
 *               targetClassId:
 *                 type: string
 *                 description: MongoDB ObjectId of the target class
 *     responses:
 *       200:
 *         description: Students promoted successfully
 *       400:
 *         description: Validation error
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ValidationError'
 */

router.post('/promote', requirePermission('students:promote'), promoteStudents);

/**
 * @swagger
 * /api/v1/students/{id}:
 *   get:
 *     tags: [Students]
 *     summary: Get a single student by ID
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: MongoDB ObjectId of the student
 *     responses:
 *       200:
 *         description: Student data
 *       404:
 *         description: Student not found
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ErrorResponse'
 */

router.get('/:id', requirePermission('students:read'), getStudentById);
/**
 * @swagger
 * /api/v1/students/{id}:
 *   put:
 *     tags: [Students]
 *     summary: Update an existing student record
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: MongoDB ObjectId of the student
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               admissionNo:
 *                 type: string
 *               rollNo:
 *                 type: string
 *               firstName:
 *                 type: string
 *               lastName:
 *                 type: string
 *               dateOfBirth:
 *                 type: string
 *                 format: date
 *               classId:
 *                 type: string
 *               guardians:
 *                 type: array
 *                 items:
 *                   type: object
 *                   properties:
 *                     name:
 *                       type: string
 *                     relationship:
 *                       type: string
 *                       enum: [Father, Mother, Grandfather, Grandmother, Uncle, Aunt, Brother, Sister, Guardian]
 *                     phone:
 *                       type: string
 *                     isPrimary:
 *                       type: boolean
 *     responses:
 *       200:
 *         description: Student updated successfully
 *       400:
 *         description: Validation error
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ValidationError'
 *       404:
 *         description: Student not found
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ErrorResponse'
 */

router.put('/:id', requirePermission('students:write'), updateStudent);
/**
 * @swagger
 * /api/v1/students/{id}:
 *   delete:
 *     tags: [Students]
 *     summary: Soft-delete (archive) a student record
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: MongoDB ObjectId of the student
 *     responses:
 *       200:
 *         description: Student archived successfully
 *       404:
 *         description: Student not found
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ErrorResponse'
 */

router.delete('/:id', requirePermission('students:delete'), deleteStudent);

module.exports = router;
