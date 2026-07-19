const { z } = require('zod');

const attendanceRecordInput = z.object({
  studentId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Student ID format'),
  status: z.enum(['Present', 'Absent', 'Late', 'Excused']),
  note: z.string().trim().optional(),
});

const submitAttendanceSchema = z.object({
  classId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Class ID format'),
  date: z.string().regex(/^\d{4}-\d{2}-\d{2}$/, 'Date must be in YYYY-MM-DD format'),
  records: z.array(attendanceRecordInput).min(1, 'Attendance list cannot be empty'),
});

const monthlySheetQuerySchema = z.object({
  classId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Class ID format'),
  monthYear: z.string().regex(/^\d{4}-\d{2}$/, 'Month must be in YYYY-MM format'),
});

module.exports = { attendanceRecordInput, submitAttendanceSchema, monthlySheetQuerySchema };
