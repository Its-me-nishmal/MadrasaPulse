import '../../../models/exam.dart';
import '../../../models/meta.dart';
import '../../../core/network/api_config.dart';
import '../../../core/network/dio_client.dart';

class ExamRepository {
  final DioClient _dio;
  ExamRepository(this._dio);

  Future<({List<ExamRecord> records, Meta meta})> getExamRecords(
    String classId,
    String examId,
    String subjectName,
  ) async {
    final response = await _dio.get(ApiConfig.examsRecords, queryParameters: {
      'classId': classId,
      'examId': examId,
      'subjectName': subjectName,
    });
    final data = response.data;
    final records = (data['data'] as List)
        .map((e) => ExamRecord.fromJson(e))
        .toList();
    final meta = Meta.fromJson(data['meta']);
    return (records: records, meta: meta);
  }

  Future<ExamRecord> submitGrades(Map<String, dynamic> data) async {
    final response =
        await _dio.post(ApiConfig.examsRecords, data: data);
    return ExamRecord.fromJson(response.data['data']);
  }

  Future<List<ReportCardItem>> getReportCard(String studentId) async {
    final response = await _dio.get(
      ApiConfig.examsReportCard,
      queryParameters: {'studentId': studentId},
    );
    final data = response.data['data'] as List;
    return data.map((e) => ReportCardItem.fromJson(e)).toList();
  }
}
