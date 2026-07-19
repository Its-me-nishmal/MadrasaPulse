const { z } = require('zod');

const guardianSchema = z.object({
  name: z.string().trim().min(2),
  relationship: z.enum(['Father', 'Mother', 'Grandfather', 'Grandmother', 'Uncle', 'Aunt', 'Brother', 'Sister', 'Guardian']),
  phone: z.string().trim().min(7),
  isPrimary: z.boolean().default(false),
});

const studentCreateSchema = z.object({
  admissionNo: z.string().trim().min(1),
  rollNo: z.string().trim().optional(),
  firstName: z.string().trim().min(1),
  lastName: z.string().trim().min(1),
  dateOfBirth: z.string().transform(val => new Date(val)),
  classId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Class ID format').optional(),
  guardians: z.array(guardianSchema).min(1, 'At least one guardian contact is required'),
});

const studentUpdateSchema = studentCreateSchema.partial();

const promoteSchema = z.object({
  studentIds: z.array(z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Student ID format')).min(1),
  targetClassId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Class ID format'),
});

module.exports = { guardianSchema, studentCreateSchema, studentUpdateSchema, promoteSchema };
