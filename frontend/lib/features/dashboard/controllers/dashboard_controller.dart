import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/network/api_config.dart';

class DashboardState {
  final int totalStudents;
  final int totalTeachers;
  final int todayPresent;
  final double totalDue;
  final bool isLoading;
  final String? error;

  const DashboardState({
    this.totalStudents = 0,
    this.totalTeachers = 0,
    this.todayPresent = 0,
    this.totalDue = 0,
    this.isLoading = false,
    this.error,
  });

  DashboardState copyWith({
    int? totalStudents,
    int? totalTeachers,
    int? todayPresent,
    double? totalDue,
    bool? isLoading,
    String? error,
  }) {
    return DashboardState(
      totalStudents: totalStudents ?? this.totalStudents,
      totalTeachers: totalTeachers ?? this.totalTeachers,
      todayPresent: todayPresent ?? this.todayPresent,
      totalDue: totalDue ?? this.totalDue,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class DashboardController extends StateNotifier<DashboardState> {
  final DioClient _dio;
  DashboardController(this._dio) : super(const DashboardState());

  Future<void> loadDashboard() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final studentsRes = await _dio.get(ApiConfig.students());
      final studentsList = studentsRes.data['data'] as List;

      final teachersRes = await _dio.get(ApiConfig.teachers());
      final teachersList = teachersRes.data['data'] as List;

      state = state.copyWith(
        totalStudents: studentsList.length,
        totalTeachers: teachersList.length,
        todayPresent: studentsList.length, // Placeholder logic
        totalDue: 150.0, // Placeholder logic
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final dashboardControllerProvider =
    StateNotifierProvider<DashboardController, DashboardState>((ref) {
  final dio = ref.read(dioClientProvider);
  return DashboardController(dio);
});
