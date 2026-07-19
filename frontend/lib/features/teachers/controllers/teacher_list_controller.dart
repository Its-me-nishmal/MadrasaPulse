import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_provider.dart';
import '../../../models/teacher.dart';
import '../../../models/meta.dart';
import '../repositories/teacher_repository.dart';

class TeacherListState {
  final List<Teacher> teachers;
  final Meta meta;
  final bool isLoading;
  final String? error;
  final String? search;

  const TeacherListState({
    this.teachers = const [],
    this.meta = const Meta(),
    this.isLoading = false,
    this.error,
    this.search,
  });

  TeacherListState copyWith({
    List<Teacher>? teachers,
    Meta? meta,
    bool? isLoading,
    String? error,
    String? search,
  }) {
    return TeacherListState(
      teachers: teachers ?? this.teachers,
      meta: meta ?? this.meta,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      search: search ?? this.search,
    );
  }
}

class TeacherListController extends StateNotifier<TeacherListState> {
  final TeacherRepository _repo;
  TeacherListController(this._repo) : super(const TeacherListState());

  Future<void> loadTeachers({int page = 1}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repo.getTeachers(page: page, search: state.search);
      state = state.copyWith(teachers: result.teachers, meta: result.meta, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void setSearch(String query) {
    state = state.copyWith(search: query.isEmpty ? null : query);
    loadTeachers();
  }
}

final teacherListControllerProvider =
    StateNotifierProvider<TeacherListController, TeacherListState>((ref) {
  final dio = ref.read(dioClientProvider);
  return TeacherListController(TeacherRepository(dio));
});
