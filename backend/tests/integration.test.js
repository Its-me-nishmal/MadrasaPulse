const request = require('supertest');
const mongoose = require('mongoose');
const app = require('../src/app');

// Models
const User = require('../src/models/User');
const Student = require('../src/models/Student');
const Teacher = require('../src/models/Teacher');
const Attendance = require('../src/models/Attendance');
const FeeLedger = require('../src/models/FeeLedger');
const ExamRecord = require('../src/models/ExamRecord');
const DeviceToken = require('../src/models/DeviceToken');

const TEST_MONGO_URI = 'mongodb://localhost:27017/madrasapulse_integration_test';
const TEST_MADRASA_ID = '60d5ec49c6d1a21e483e5896';
const TARGET_CLASS_ID = '60d5ec49c6d1a21e483e5890';
const PROMOTED_CLASS_ID = '60d5ec49c6d1a21e483e5899';
const TEST_EXAM_ID = '60d5ec49c6d1a21e483e589a';

describe('MadrasaPulse Backend Integration Testing Suite', () => {
  let accessToken;
  let refreshToken;
  let testStudentId;
  let testTeacherId;

  beforeAll(async () => {
    // Connect to test MongoDB database
    await mongoose.connect(TEST_MONGO_URI);
  });

  afterAll(async () => {
    // Drop the test database and close connections
    await mongoose.connection.db.dropDatabase();
    await mongoose.disconnect();
  });

  describe('1. Health Check Endpoint', () => {
    it('should return 200 OK and server operational message', async () => {
      const res = await request(app).get('/api/v1/health');
      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(res.body.message).toContain('running smoothly');
    });
  });

  describe('2. User Authentication & Authorization Services', () => {
    it('should successfully register a MadrasaAdmin user profile', async () => {
      const res = await request(app)
        .post('/api/v1/auth/register')
        .send({
          madrasaId: TEST_MADRASA_ID,
          username: 'integrationadmin',
          password: 'securetestpassword',
          role: 'MadrasaAdmin'
        });

      expect(res.status).toBe(201);
      expect(res.body.success).toBe(true);
      expect(res.body.data.user.username).toBe('integrationadmin');
      expect(res.body.data.user.role).toBe('MadrasaAdmin');
      expect(res.body.data.accessToken).toBeDefined();

      accessToken = res.body.data.accessToken;
      refreshToken = res.body.data.refreshToken;
    });

    it('should login successfully with registered credentials', async () => {
      const res = await request(app)
        .post('/api/v1/auth/login')
        .send({
          madrasaId: TEST_MADRASA_ID,
          username: 'integrationadmin',
          password: 'securetestpassword'
        });

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(res.body.data.accessToken).toBeDefined();
    });

    it('should successfully rotate access token using refresh token', async () => {
      const res = await request(app)
        .post('/api/v1/auth/refresh')
        .send({ refreshToken });

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(res.body.data.accessToken).toBeDefined();
      accessToken = res.body.data.accessToken; // Use the new access token
    });

    it('should access protected profile route with bearer authorization', async () => {
      const res = await request(app)
        .get('/api/v1/auth/me')
        .set('Authorization', `Bearer ${accessToken}`);

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(res.body.data.user.role).toBe('MadrasaAdmin');
    });

    it('should reject requests lacking auth header', async () => {
      const res = await request(app).get('/api/v1/auth/me');
      expect(res.status).toBe(401);
      expect(res.body.success).toBe(false);
    });
  });

  describe('3. Student Management API Services', () => {
    it('should successfully register a student profile', async () => {
      const res = await request(app)
        .post('/api/v1/students')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          admissionNo: 'STUD-INTEG-001',
          firstName: 'Aisha',
          lastName: 'Rahman',
          dateOfBirth: '2016-04-12',
          classId: TARGET_CLASS_ID,
          guardians: [{
            name: 'Imran Rahman',
            relationship: 'Father',
            phone: '+919988776655',
            isPrimary: true
          }]
        });

      expect(res.status).toBe(201);
      expect(res.body.success).toBe(true);
      expect(res.body.data.firstName).toBe('Aisha');
      testStudentId = res.body.data._id;
    });

    it('should reject duplicate admission number registration', async () => {
      const res = await request(app)
        .post('/api/v1/students')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          admissionNo: 'STUD-INTEG-001',
          firstName: 'Duplicate',
          lastName: 'Student',
          dateOfBirth: '2016-04-12',
          guardians: [{
            name: 'Father',
            relationship: 'Father',
            phone: '+919988776655',
            isPrimary: true
          }]
        });

      expect(res.status).toBe(409);
      expect(res.body.success).toBe(false);
    });

    it('should retrieve student directory with pagination stats', async () => {
      const res = await request(app)
        .get('/api/v1/students')
        .set('Authorization', `Bearer ${accessToken}`);

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(res.body.meta.total).toBe(1);
    });

    it('should promote students in bulk to a target class', async () => {
      const res = await request(app)
        .post('/api/v1/students/promote')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          studentIds: [testStudentId],
          targetClassId: PROMOTED_CLASS_ID
        });

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(res.body.modifiedCount).toBe(1);
    });
  });

  describe('4. Teacher Management API Services', () => {
    it('should successfully onboard a teacher profile', async () => {
      const res = await request(app)
        .post('/api/v1/teachers')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          staffId: 'TCH-INTEG-001',
          firstName: 'Omar',
          lastName: 'Faruq',
          phone: '+918877665544',
          email: 'omar.faruq@madrasa.com',
          qualifications: ['Hafiz', 'Alim'],
          assignedClasses: [{
            classId: TARGET_CLASS_ID,
            subjectName: 'Hadith Studies'
          }]
        });

      expect(res.status).toBe(201);
      expect(res.body.success).toBe(true);
      expect(res.body.data.firstName).toBe('Omar');
      testTeacherId = res.body.data._id;
    });

    it('should retrieve teachers directory', async () => {
      const res = await request(app)
        .get('/api/v1/teachers')
        .set('Authorization', `Bearer ${accessToken}`);

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(res.body.meta.total).toBe(1);
    });
  });

  describe('5. Attendance Management API Services', () => {
    it('should submit daily class attendance records successfully', async () => {
      const res = await request(app)
        .post('/api/v1/attendance')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          classId: TARGET_CLASS_ID,
          date: '2026-07-19',
          records: [{
            studentId: testStudentId,
            status: 'Present',
            note: 'Regular'
          }]
        });

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(res.body.data.dailyLogs[0].day).toBe(19);
    });

    it('should fetch monthly class attendance sheet grids', async () => {
      const res = await request(app)
        .get(`/api/v1/attendance/sheet?classId=${TARGET_CLASS_ID}&monthYear=2026-07`)
        .set('Authorization', `Bearer ${accessToken}`);

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(res.body.data.dailyLogs.length).toBe(1);
    });

    it('should retrieve monthly class statistics summary', async () => {
      const res = await request(app)
        .get(`/api/v1/attendance/summary?classId=${TARGET_CLASS_ID}&monthYear=2026-07`)
        .set('Authorization', `Bearer ${accessToken}`);

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(res.body.data.attendanceRate).toBe(100);
    });
  });

  describe('6. Fees & Financial Payments API Services', () => {
    it('should post a new invoice to student ledger', async () => {
      const res = await request(app)
        .post('/api/v1/fees/invoice')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          studentId: testStudentId,
          academicYear: '2026-2027',
          invoiceNo: 'INV-INTEG-001',
          title: 'August Tuition Fee',
          amount: 2000,
          dueDate: '2026-08-15'
        });

      expect(res.status).toBe(201);
      expect(res.body.success).toBe(true);
    });

    it('should record a payment transaction and update balance statuses', async () => {
      const res = await request(app)
        .post('/api/v1/fees/pay')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          invoiceNo: 'INV-INTEG-001',
          amountPaid: 2000,
          paymentMethod: 'Cash',
          transactionId: 'TXN-INTEG-9988'
        });

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(res.body.data.invoices[0].status).toBe('Paid');
    });

    it('should retrieve student historical ledger lists', async () => {
      const res = await request(app)
        .get(`/api/v1/fees/ledger/${testStudentId}?academicYear=2026-2027`)
        .set('Authorization', `Bearer ${accessToken}`);

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(res.body.data.invoices.length).toBe(1);
    });
  });

  describe('7. Exams & Performance Assessment API Services', () => {
    it('should submit exam grade scores sheet successfully', async () => {
      const res = await request(app)
        .post('/api/v1/exams')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          classId: TARGET_CLASS_ID,
          examId: TEST_EXAM_ID,
          subjectName: 'Hadith Studies',
          maxMarks: 100,
          records: [{
            studentId: testStudentId,
            marksObtained: 92,
            remarks: 'Superb focus'
          }]
        });

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
    });

    it('should aggregate student academic report cards', async () => {
      const res = await request(app)
        .get(`/api/v1/exams/report/${testStudentId}`)
        .set('Authorization', `Bearer ${accessToken}`);

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(res.body.data.scores.length).toBe(1);
      expect(res.body.data.scores[0].percentage).toBe(92);
    });
  });

  describe('8. Communication & Messaging alerts API Services', () => {
    it('should successfully register a device token', async () => {
      const res = await request(app)
        .post('/api/v1/communication/device-token')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          token: 'fcm_device_token_integration_99',
          platform: 'ios'
        });

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
    });

    it('should trigger alert dispatches successfully', async () => {
      const res = await request(app)
        .post('/api/v1/communication/send-alert')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          recipientPhone: '+919988776655',
          messageType: 'exam',
          message: 'Aisha Rahman scored 92% in Midterm exams.'
        });

      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
    });
  });
});
