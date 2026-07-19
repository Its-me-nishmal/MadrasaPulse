const { z } = require('zod');

const registerSchema = z.object({
  madrasaId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Madrasa ID format'),
  username: z.string().min(3, 'Username must be at least 3 characters long'),
  password: z.string().min(6, 'Password must be at least 6 characters long'),
  role: z.enum(['SuperAdmin', 'MadrasaAdmin', 'Teacher', 'Parent', 'Student']),
  linkedEntityId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Entity ID format').optional()
});

const loginSchema = z.object({
  madrasaId: z.string().regex(/^[0-9a-fA-F]{24}$/, 'Invalid Madrasa ID format'),
  username: z.string().trim().toLowerCase(),
  password: z.string()
});

const refreshSchema = z.object({
  refreshToken: z.string()
});

module.exports = { registerSchema, loginSchema, refreshSchema };
