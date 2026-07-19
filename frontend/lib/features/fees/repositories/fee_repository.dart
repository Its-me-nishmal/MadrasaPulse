import '../../../core/network/api_config.dart';
import '../../../models/fee.dart';
import '../../../core/network/dio_client.dart';

class FeeRepository {
  final DioClient _dio;
  FeeRepository(this._dio);

  Future<FeeLedger> getLedger(String studentId, String academicYear) async {
    final response = await _dio.get(ApiConfig.feesStudentLedger(studentId), queryParameters: {'academicYear': academicYear});
    return FeeLedger.fromJson(response.data['data']);
  }
}
