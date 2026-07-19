import 'package:dio/dio.dart';
import '../../../core/network/api_config.dart';
import '../../../core/network/dio_client.dart';
import '../../../models/student.dart';
import '../../../models/meta.dart';

class StudentRepository {
  final DioClient _dio;

  StudentRepository(this._dio);

  Future<({List<Student> students, Meta meta})> getStudents({
    int page = 1,
    int limit = 20,
    String? classId,
    String? search,
  }) async {
    final params = <String, dynamic>{'page': page, 'limit': limit};
    if (classId != null) params['classId'] = classId;
    if (search != null) params['search'] = search;

    final response = await _dio.get(ApiConfig.students(), queryParameters: params);
    final data = response.data;
    final students = (data['data'] as List).map((e) => Student.fromJson(e)).toList();
    final meta = Meta.fromJson(data['meta']);
    return (students: students, meta: meta);
  }

  Future<Student> getStudentById(String id) async {
    final response = await _dio.get(ApiConfig.students(id: id));
    return Student.fromJson(response.data['data']);
  }

  Future<Student> createStudent(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiConfig.students(), data: data);
    return Student.fromJson(response.data['data']);
  }

  Future<Student> updateStudent(String id, Map<String, dynamic> data) async {
    final response = await _dio.put(ApiConfig.students(id: id), data: data);
    return Student.fromJson(response.data['data']);
  }

  Future<void> deleteStudent(String id) async {
    await _dio.delete(ApiConfig.students(id: id));
  }

  Future<({int modifiedCount})> promoteStudents(
      List<String> studentIds, String targetClassId) async {
    final response = await _dio.post(ApiConfig.promoteStudents, data: {
      'studentIds': studentIds,
      'targetClassId': targetClassId,
    });
    return (modifiedCount: response.data['modifiedCount'] as int);
  }
}
