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

// Teacher Onboarding & Allocation Endpoints
router.post('/', requirePermission('teachers:write'), createTeacher);
router.get('/', requirePermission('teachers:read'), getTeachers);

router.get('/:id', requirePermission('teachers:read'), getTeacherById);
router.put('/:id', requirePermission('teachers:write'), updateTeacher);
router.delete('/:id', requirePermission('teachers:delete'), deleteTeacher);

module.exports = router;
