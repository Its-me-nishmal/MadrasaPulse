import '../../../models/exam.dart';
import '../../../models/meta.dart';
import '../../../core/network/api_config.dart';
import '../../../core/network/dio_client.dart';

class ExamRepository {
  final DioClient _dio;
  ExamRepository(this._dio);
}
