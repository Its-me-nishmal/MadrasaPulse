import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/router/router_notifier.dart';
import '../../../models/user.dart';

enum AuthStatus { uninitialized, authenticated, unauthenticated }

class AuthController extends StateNotifier<AuthStatus> {
  final DioClient _dio;
  final RouterNotifier _routerNotifier;

  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;

  AuthController(this._dio, this._routerNotifier)
      : super(AuthStatus.uninitialized);

  Future<void> tryAutoLogin() async {
    final storedAccess = _getStoredAccessToken();
    if (storedAccess != null) {
      _dio.setTokens(access: storedAccess);
      try {
        final response = await _dio.get('/auth/me');
        _currentUser = AppUser.fromJson(response.data['data']);
        state = AuthStatus.authenticated;
        _routerNotifier.login();
        return;
      } catch (_) {}
    }
    state = AuthStatus.unauthenticated;
    _routerNotifier.setAuth(false);
  }

  Future<String?> login(
      String madrasaId, String username, String password,
      ) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'madrasaId': madrasaId,
          'username': username,
          'password': password,
        },
      );
      final data = response.data['data'];
      _currentUser = AppUser.fromJson(data['user']);
      _dio.setTokens(
          access: data['accessToken'], refresh: data['refreshToken'],
          );
      _persistTokens(data['accessToken'], data['refreshToken']);
      state = AuthStatus.authenticated;
      _routerNotifier.login();
      return null;
    } catch (e) {
      return 'Login failed. Check your credentials.';
    }
  }

  void logout() {
    _currentUser = null;
    _dio.clearTokens();
    _clearTokens();
    state = AuthStatus.unauthenticated;
    _routerNotifier.logout();
  }

  void _persistTokens(String access, String refresh) {}

  String? _getStoredAccessToken() => null;

  void _clearTokens() {}
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
