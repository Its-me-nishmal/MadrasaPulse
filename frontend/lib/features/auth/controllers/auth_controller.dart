import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/router/router_notifier.dart';
import '../../../core/network/api_config.dart';
import '../../../models/user.dart';

enum AuthStatus { uninitialized, authenticated, unauthenticated }

class AuthController extends StateNotifier<AuthStatus> {
  final DioClient _dio;
  final RouterNotifier _routerNotifier;
  final _storage = const FlutterSecureStorage();

  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;

  AuthController(this._dio, this._routerNotifier)
      : super(AuthStatus.uninitialized);

  Future<void> tryAutoLogin() async {
    final storedAccess = await _getStoredAccessToken();
    if (storedAccess != null) {
      _dio.setTokens(access: storedAccess);
      try {
        final response = await _dio.get(ApiConfig.authMe);
        _currentUser = AppUser.fromJson(response.data['data']['user']);
        state = AuthStatus.authenticated;
        _routerNotifier.login();
        return;
      } catch (_) {}
    }
    state = AuthStatus.unauthenticated;
    _routerNotifier.setAuth(false);
  }

  Future<String?> login(
    String madrasaId,
    String username,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        ApiConfig.login,
        data: {
          'madrasaId': madrasaId,
          'username': username,
          'password': password,
        },
      );
      final data = response.data['data'];
      _currentUser = AppUser.fromJson(data['user']);
      _dio.setTokens(
        access: data['accessToken'],
        refresh: data['refreshToken'],
      );
      await _persistTokens(data['accessToken'], data['refreshToken']);
      state = AuthStatus.authenticated;
      _routerNotifier.login();
      return null;
    } catch (e) {
      return 'Login failed: $e';
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    _dio.clearTokens();
    await _clearTokens();
    state = AuthStatus.unauthenticated;
    _routerNotifier.logout();
  }

  Future<void> _persistTokens(String access, String refresh) async {
    await _storage.write(key: 'access_token', value: access);
    await _storage.write(key: 'refresh_token', value: refresh);
  }

  Future<String?> _getStoredAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<void> _clearTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthStatus>((ref) {
  final dio = ref.read(dioClientProvider);
  final routerNotifier = ref.read(routerNotifierProvider);
  return AuthController(dio, routerNotifier);
});

final currentUserProvider = Provider<AppUser?>((ref) {
  final controller = ref.read(authControllerProvider.notifier);
  return controller.currentUser;
});
