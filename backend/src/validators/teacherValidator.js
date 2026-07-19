const { z } = require('zod');

const assignmentSchema = z.object({
  classId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Class ID format'),
  subjectName: z.string().trim().min(1),
});

const teacherCreateSchema = z.object({
  staffId: z.string().trim().min(1),
  firstName: z.string().trim().min(1),
  lastName: z.string().trim().min(1),
  phone: z.string().trim().min(7),
  email: z.string().trim().email().optional().or(z.literal('')),
  qualifications: z.array(z.string()).default([]),
  assignedClasses: z.array(assignmentSchema).default([]),
});

const teacherUpdateSchema = teacherCreateSchema.partial();

module.exports = { assignmentSchema, teacherCreateSchema, teacherUpdateSchema };
