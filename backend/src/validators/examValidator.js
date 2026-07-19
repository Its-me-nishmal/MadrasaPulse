const { z } = require('zod');

const scoreInputSchema = z.object({
  studentId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Student ID format'),
  marksObtained: z.number().min(0),
  remarks: z.string().trim().optional(),
});

const submitMarksSchema = z.object({
  classId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Class ID format'),
  examId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Exam ID format'),
  subjectName: z.string().trim().min(1),
  maxMarks: z.number().min(1).default(100),
  records: z.array(scoreInputSchema).min(1, 'Marks entry list cannot be empty'),
});

const classMarksQuerySchema = z.object({
  classId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Class ID format'),
  examId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Exam ID format'),
  subjectName: z.string().trim().min(1),
});

module.exports = { scoreInputSchema, submitMarksSchema, classMarksQuerySchema };
