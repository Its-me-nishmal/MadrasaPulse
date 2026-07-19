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

router.post('/', requirePermission('exams:write'), submitMarks);
router.get('/', requirePermission('exams:read'), getClassMarks);
router.get('/report/:studentId', requirePermission('exams:read'), getStudentReportCard);

module.exports = router;
