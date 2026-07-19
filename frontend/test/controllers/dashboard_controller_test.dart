import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:madrasapulse_frontend/features/dashboard/controllers/dashboard_controller.dart';

void main() {
  group('DashboardController', () {
    test('initial state has zeros', () {
      final container = ProviderContainer();
      final state = container.read(dashboardControllerProvider);
      expect(state.totalStudents, 0);
      expect(state.totalTeachers, 0);
      expect(state.isLoading, false);
      container.dispose();
    });
  });
}
