const Teacher = require('../models/Teacher');

/**
 * Create a new teacher record after checking for duplicate staff ID
 * @param {String} madrasaId - The madrasa tenant ID
 * @param {Object} data - Teacher data payload
 * @returns {Promise<Object>} The created teacher document
 */
const createTeacher = async (madrasaId, data) => {
  const existing = await Teacher.findOne({ madrasaId, staffId: data.staffId, isDeleted: false });
  if (existing) {
    const error = new Error(`Staff ID ${data.staffId} is already registered.`);
    error.statusCode = 409;
    error.code = 'STAFF_EXISTS';
    throw error;
  }
  const teacher = new Teacher({ ...data, madrasaId });
  await teacher.save();
  return teacher;
};

/**
 * Retrieve a paginated list of teachers with optional classId, subjectName, and search filters
 * @param {String} madrasaId - The madrasa tenant ID
 * @param {Object} [queryParams={}] - Query parameters: classId, subjectName, search, page, limit
 * @returns {Promise<{teachers: Object[], meta: {total: Number, page: Number, limit: Number, pages: Number}}>}
 */
const getTeachers = async (madrasaId, queryParams = {}) => {
  const { classId, subjectName, search } = queryParams;
  let { page = 1, limit = 20 } = queryParams;
  page = Math.max(1, parseInt(page));
  limit = Math.min(100, Math.max(1, parseInt(limit)));
  const query = { madrasaId, isDeleted: false };
  if (classId) query['assignedClasses.classId'] = classId;
  if (subjectName) query['assignedClasses.subjectName'] = { $regex: subjectName, $options: 'i' };
  if (search) {
    query.$or = [
      { firstName: { $regex: search, $options: 'i' } },
      { lastName: { $regex: search, $options: 'i' } },
      { staffId: { $regex: search, $options: 'i' } },
    ];
  }
  const total = await Teacher.countDocuments(query);
  const pages = Math.ceil(total / limit);
  const teachers = await Teacher.find(query)
    .skip((page - 1) * limit)
    .limit(limit)
    .sort({ firstName: 1 });
  return { teachers, meta: { total, page, limit, pages } };
};

/**
 * Get a single teacher by ID scoped to the madrasa tenant
 * @param {String} teacherId - The teacher's MongoDB ObjectId
 * @param {String} madrasaId - The madrasa tenant ID
 * @returns {Promise<Object>} The teacher document
 */
const getTeacherById = async (teacherId, madrasaId) => {
  const teacher = await Teacher.findOne({ _id: teacherId, madrasaId, isDeleted: false });
  if (!teacher) {
    const error = new Error('Teacher profile not found or belongs to another tenant.');
    error.statusCode = 404;
    error.code = 'TEACHER_NOT_FOUND';
    throw error;
  }
  return teacher;
};

/**
 * Update a teacher record by ID scoped to the madrasa tenant
 * @param {String} teacherId - The teacher's MongoDB ObjectId
 * @param {String} madrasaId - The madrasa tenant ID
 * @param {Object} data - Fields to update on the teacher document
 * @returns {Promise<Object>} The updated teacher document
 */
const updateTeacher = async (teacherId, madrasaId, data) => {
  const teacher = await Teacher.findOneAndUpdate(
    { _id: teacherId, madrasaId, isDeleted: false },
    { $set: data },
    { new: true, runValidators: true }
  );
  if (!teacher) {
    const error = new Error('Teacher profile not found or belongs to another tenant.');
    error.statusCode = 404;
    error.code = 'TEACHER_NOT_FOUND';
    throw error;
  }
  return teacher;
};

/**
 * Soft-delete a teacher record by setting isDeleted flag
 * @param {String} teacherId - The teacher's MongoDB ObjectId
 * @param {String} madrasaId - The madrasa tenant ID
 * @returns {Promise<Object>} The updated teacher document
 */
const deleteTeacher = async (teacherId, madrasaId) => {
  const teacher = await Teacher.findOneAndUpdate(
    { _id: teacherId, madrasaId, isDeleted: false },
    { $set: { isDeleted: true } },
    { new: true }
  );
  if (!teacher) {
    const error = new Error('Teacher profile not found or belongs to another tenant.');
    error.statusCode = 404;
    error.code = 'TEACHER_NOT_FOUND';
    throw error;
  }
  return teacher;
};

module.exports = { createTeacher, getTeachers, getTeacherById, updateTeacher, deleteTeacher };
