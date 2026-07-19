import '../../../core/network/api_config.dart';
import '../../../models/attendance.dart';
import '../../../models/meta.dart';
import '../../../core/network/dio_client.dart';

class AttendanceRepository {
  final DioClient _dio;
  AttendanceRepository(this._dio);

  Future<AttendanceBucket> submitAttendance({
    required String classId,
    required String date,
    required List<Map<String, dynamic>> records,
  }) async {
    final response = await _dio.post(ApiConfig.attendanceSubmit, data: {
      'classId': classId,
      'date': date,
      'records': records,
    });
    return AttendanceBucket.fromJson(response.data['data']);
  }

  Future<AttendanceBucket> getMonthlySheet(String classId, String monthYear) async {
    final response = await _dio.get(ApiConfig.attendanceSheet, queryParameters: {'classId': classId, 'monthYear': monthYear});
    return AttendanceBucket.fromJson(response.data['data']);
  }

  Future<AttendanceSummary> getSummary(String classId, String monthYear) async {
    final response = await _dio.get(ApiConfig.attendanceSummary, queryParameters: {'classId': classId, 'monthYear': monthYear});
    return AttendanceSummary.fromJson(response.data['data']);
  }
}
