import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:madrasapulse_frontend/features/auth/controllers/auth_controller.dart';

void main() {
  group('AuthController', () {
    test('initial status is uninitialized', () {
      final container = ProviderContainer();
      final status = container.read(authControllerProvider);
      expect(status, AuthStatus.uninitialized);
      container.dispose();
    });
  });
}
