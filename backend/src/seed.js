require('dotenv').config();
const connectDB = require('./config/db');
const Madrasa = require('./models/Madrasa');
const User = require('./models/User');
const Student = require('./models/Student');
const Teacher = require('./models/Teacher');

const seedData = async () => {
  try {
    await connectDB();
    console.log('Connected to MongoDB for seeding...');

    // Clear existing data
    await Promise.all([
      Madrasa.deleteMany({}),
      User.deleteMany({}),
      Student.deleteMany({}),
      Teacher.deleteMany({}),
    ]);
    console.log('Cleared existing data.');

    // Seed Madrasa
    const madrasa = await Madrasa.create({
      name: 'Al-Falah Islamic Academy',
      domain: 'alfalah',
      contactInfo: { phone: '+911234567890', email: 'info@alfalah.edu' },
      enabledModules: ['students', 'teachers', 'attendance', 'fees', 'exams', 'communication'],
      subscription: { plan: 'Premium', expiresAt: new Date('2027-12-31') },
    });
    console.log(`Created madrasa: ${madrasa.name} (ID: ${madrasa._id})`);

    // Seed Super Admin
    const admin = await User.create({
      madrasaId: madrasa._id,
      username: 'superadmin',
      passwordHash: 'Admin@123',
      role: 'SuperAdmin',
    });
    console.log(`Created super admin: ${admin.username}`);

    // Seed Madrasa Admin
    const madrasaAdmin = await User.create({
      madrasaId: madrasa._id,
      username: 'admin',
      passwordHash: 'Admin@123',
      role: 'MadrasaAdmin',
    });
    console.log(`Created madrasa admin: ${madrasaAdmin.username}`);

    // Seed Teacher User
    const teacherUser = await User.create({
      madrasaId: madrasa._id,
      username: 'teacher1',
      passwordHash: 'Teacher@123',
      role: 'Teacher',
    });
    console.log(`Created teacher user: ${teacherUser.username}`);

    // Seed Students
    const students = await Student.insertMany([
      {
        madrasaId: madrasa._id,
        admissionNo: 'ADM-2026-001',
        rollNo: '1',
        firstName: 'Ahmed',
        lastName: 'Hassan',
        dateOfBirth: new Date('2012-05-15'),
        guardians: [{ name: 'Hassan Ahmed', relationship: 'Father', phone: '+911234567001', isPrimary: true }],
      },
      {
        madrasaId: madrasa._id,
        admissionNo: 'ADM-2026-002',
        rollNo: '2',
        firstName: 'Fatima',
        lastName: 'Ali',
        dateOfBirth: new Date('2011-08-22'),
        guardians: [{ name: 'Ali Mohammed', relationship: 'Father', phone: '+911234567002', isPrimary: true }],
      },
      {
        madrasaId: madrasa._id,
        admissionNo: 'ADM-2026-003',
        rollNo: '3',
        firstName: 'Mohammed',
        lastName: 'Ibrahim',
        dateOfBirth: new Date('2013-01-10'),
        guardians: [
          { name: 'Ibrahim Khan', relationship: 'Father', phone: '+911234567003', isPrimary: true },
          { name: 'Aisha Khan', relationship: 'Mother', phone: '+911234567004', isPrimary: false },
        ],
      },
    ]);
    console.log(`Created ${students.length} students.`);

    // Seed Teachers
    const teachers = await Teacher.insertMany([
      {
        madrasaId: madrasa._id,
        staffId: 'TCH-001',
        firstName: 'Saira',
        lastName: 'Begum',
        phone: '+911234567005',
        email: 'saira.begum@alfalah.edu',
        qualifications: ['M.Sc. Mathematics', 'B.Ed.'],
        assignedClasses: [],
      },
      {
        madrasaId: madrasa._id,
        staffId: 'TCH-002',
        firstName: 'Yusuf',
        lastName: 'Khan',
        phone: '+911234567006',
        email: 'yusuf.khan@alfalah.edu',
        qualifications: ['M.A. Arabic', 'B.Ed.'],
        assignedClasses: [],
      },
    ]);
    console.log(`Created ${teachers.length} teachers.`);

    console.log('\n--- Seed Complete ---');
    console.log('Login credentials:');
    console.log('  SuperAdmin: username=superadmin, password=Admin@123');
    console.log('  MadrasaAdmin: username=admin, password=Admin@123');
    console.log('  Teacher: username=teacher1, password=Teacher@123');
    console.log(`  Madrasa ID: ${madrasa._id}`);

    process.exit(0);
  } catch (error) {
    console.error('Seed error:', error);
    process.exit(1);
  }
};

seedData();
