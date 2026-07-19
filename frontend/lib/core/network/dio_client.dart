import 'package:dio/dio.dart';
import 'api_config.dart';

class DioClient {
  late final Dio _dio;
  String? _accessToken;
  String? _refreshToken;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_accessToken != null) {
            options.headers['Authorization'] = 'Bearer $_accessToken';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401 && _refreshToken != null) {
            try {
              final refreshResp = await _dio.post(
                ApiConfig.refreshToken,
                data: {
                  'refreshToken': _refreshToken,
                },
              );
              final newAccessToken =
                  refreshResp.data['data']['accessToken'] as String;
              _accessToken = newAccessToken;
              final failedRequest = e.requestOptions;
              failedRequest.headers['Authorization'] = 'Bearer $_accessToken';
              final response = await _dio.fetch(failedRequest);
              handler.resolve(response);
              return;
            } catch (_) {}
          }
          handler.next(e);
        },
      ),
    );
  }

  void setTokens({String? access, String? refresh}) {
    _accessToken = access;
    _refreshToken = refresh;
  }

  void clearTokens() {
    _accessToken = null;
    _refreshToken = null;
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {Map<String, dynamic>? data}) {
    return _dio.put(path, data: data);
  }

  Future<Response> delete(String path) {
    return _dio.delete(path);
  }
}
