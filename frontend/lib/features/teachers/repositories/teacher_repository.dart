import '../../../core/network/api_config.dart';
import '../../../core/network/dio_client.dart';
import '../../../models/teacher.dart';
import '../../../models/meta.dart';

class TeacherRepository {
  final DioClient _dio;
  TeacherRepository(this._dio);

  Future<({List<Teacher> teachers, Meta meta})> getTeachers({
    int page = 1,
    int limit = 20,
    String? search,
  }) async {
    final params = <String, dynamic>{'page': page, 'limit': limit};
    if (search != null) params['search'] = search;
    final response = await _dio.get(ApiConfig.teachers(), queryParameters: params);
    final data = response.data;
    final teachers = (data['data'] as List).map((e) => Teacher.fromJson(e)).toList();
    final meta = Meta.fromJson(data['meta']);
    return (teachers: teachers, meta: meta);
  }

  Future<Teacher> getTeacherById(String id) async {
    final response = await _dio.get(ApiConfig.teachers(id: id));
    return Teacher.fromJson(response.data['data']);
  }

  Future<Teacher> createTeacher(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiConfig.teachers(), data: data);
    return Teacher.fromJson(response.data['data']);
  }

  Future<Teacher> updateTeacher(String id, Map<String, dynamic> data) async {
    final response = await _dio.put(ApiConfig.teachers(id: id), data: data);
    return Teacher.fromJson(response.data['data']);
  }

  Future<void> deleteTeacher(String id) async {
    await _dio.delete(ApiConfig.teachers(id: id));
  }
}
