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

// Student Management Endpoints mapped with specific permission guards
router.post('/', requirePermission('students:write'), createStudent);
router.get('/', requirePermission('students:read'), getStudents);
router.post('/promote', requirePermission('students:promote'), promoteStudents);

router.get('/:id', requirePermission('students:read'), getStudentById);
router.put('/:id', requirePermission('students:write'), updateStudent);
router.delete('/:id', requirePermission('students:delete'), deleteStudent);

module.exports = router;
