class ApiConfig {
  static const String baseUrl = 'http://localhost:5000/api/v1';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 30);

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
  static const String health = '/health';

  static String students({String? id}) => id != null ? '/students/$id' : '/students';
  static const String promoteStudents = '/students/promote';
  static String teachers({String? id}) => id != null ? '/teachers/$id' : '/teachers';
  static const String attendanceSubmit = '/attendance/submit';
  static const String attendanceSheet = '/attendance/sheet';
  static const String attendanceSummary = '/attendance/summary';
  static const String feesCreateInvoice = '/fees/invoice';
  static String feesStudentLedger(String studentId) => '/fees/ledger/$studentId';
  static const String feesPayment = '/fees/payment';
  static const String examsRecords = '/exams/records';
  static const String examsReportCard = '/exams/report-card';
}
