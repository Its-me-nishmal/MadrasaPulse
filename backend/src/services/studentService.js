const mongoose = require('mongoose');
const Student = require('../models/Student');

/**
 * Create a new student record after checking for duplicate admission number
 * @param {String} madrasaId - The madrasa tenant ID
 * @param {Object} data - Student data payload
 * @returns {Promise<Object>} The created student document
 */
const createStudent = async (madrasaId, data) => {
  const existingStudent = await Student.findOne({
    madrasaId,
    admissionNo: data.admissionNo,
    isDeleted: false,
  });
  if (existingStudent) {
    const error = new Error(`Admission number ${data.admissionNo} is already registered.`);
    error.statusCode = 409;
    error.code = 'ADMISSION_EXISTS';
    throw error;
  }
  const student = new Student({ ...data, madrasaId });
  await student.save();
  return student;
};

/**
 * Retrieve a paginated list of students with optional classId and search filters
 * @param {String} madrasaId - The madrasa tenant ID
 * @param {Object} [queryParams={}] - Query parameters: classId, search, page, limit
 * @returns {Promise<{students: Object[], meta: {total: Number, page: Number, limit: Number, pages: Number}}>}
 */
const getStudents = async (madrasaId, queryParams = {}) => {
  const { classId, search } = queryParams;
  let { page = 1, limit = 20 } = queryParams;
  page = Math.max(1, parseInt(page));
  limit = Math.min(100, Math.max(1, parseInt(limit)));
  const query = { madrasaId, isDeleted: false };
  if (classId) query.classId = new mongoose.Types.ObjectId(classId);
  if (search) {
    query.$or = [
      { firstName: { $regex: search, $options: 'i' } },
      { lastName: { $regex: search, $options: 'i' } },
      { admissionNo: { $regex: search, $options: 'i' } },
    ];
  }
  const total = await Student.countDocuments(query);
  const pages = Math.ceil(total / limit);
  const students = await Student.find(query)
    .skip((page - 1) * limit)
    .limit(limit)
    .sort({ firstName: 1, lastName: 1 });
  return { students, meta: { total, page, limit, pages } };
};

/**
 * Get a single student by ID scoped to the madrasa tenant
 * @param {String} studentId - The student's MongoDB ObjectId
 * @param {String} madrasaId - The madrasa tenant ID
 * @returns {Promise<Object>} The student document
 */
const getStudentById = async (studentId, madrasaId) => {
  const student = await Student.findOne({ _id: studentId, madrasaId, isDeleted: false });
  if (!student) {
    const error = new Error('Student profile not found or belongs to another tenant.');
    error.statusCode = 404;
    error.code = 'STUDENT_NOT_FOUND';
    throw error;
  }
  return student;
};

/**
 * Update a student record by ID scoped to the madrasa tenant
 * @param {String} studentId - The student's MongoDB ObjectId
 * @param {String} madrasaId - The madrasa tenant ID
 * @param {Object} data - Fields to update on the student document
 * @returns {Promise<Object>} The updated student document
 */
const updateStudent = async (studentId, madrasaId, data) => {
  const student = await Student.findOneAndUpdate(
    { _id: studentId, madrasaId, isDeleted: false },
    { $set: data },
    { new: true, runValidators: true }
  );
  if (!student) {
    const error = new Error('Student profile not found or belongs to another tenant.');
    error.statusCode = 404;
    error.code = 'STUDENT_NOT_FOUND';
    throw error;
  }
  return student;
};

/**
 * Soft-delete a student record by setting isDeleted flag
 * @param {String} studentId - The student's MongoDB ObjectId
 * @param {String} madrasaId - The madrasa tenant ID
 * @returns {Promise<Object>} The updated student document
 */
const deleteStudent = async (studentId, madrasaId) => {
  const student = await Student.findOneAndUpdate(
    { _id: studentId, madrasaId, isDeleted: false },
    { $set: { isDeleted: true } },
    { new: true }
  );
  if (!student) {
    const error = new Error('Student profile not found or belongs to another tenant.');
    error.statusCode = 404;
    error.code = 'STUDENT_NOT_FOUND';
    throw error;
  }
  return student;
};

/**
 * Promote multiple students to a target class
 * @param {String[]} studentIds - Array of student MongoDB ObjectIds
 * @param {String} targetClassId - The target class ObjectId
 * @param {String} madrasaId - The madrasa tenant ID
 * @returns {Promise<Object>} MongoDB updateMany result
 */
const promoteStudents = async (studentIds, targetClassId, madrasaId) => {
  const result = await Student.updateMany(
    { _id: { $in: studentIds }, madrasaId, isDeleted: false },
    { $set: { classId: new mongoose.Types.ObjectId(targetClassId) } }
  );
  return result;
};

module.exports = { createStudent, getStudents, getStudentById, updateStudent, deleteStudent, promoteStudents };
