import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_provider.dart';
import '../../../models/student.dart';
import '../../../models/meta.dart';
import '../repositories/student_repository.dart';

class StudentListState {
  final List<Student> students;
  final Meta meta;
  final bool isLoading;
  final String? error;
  final String? search;
  final String? classId;

  const StudentListState({
    this.students = const [],
    this.meta = const Meta(),
    this.isLoading = false,
    this.error,
    this.search,
    this.classId,
  });

  StudentListState copyWith({
    List<Student>? students,
    Meta? meta,
    bool? isLoading,
    String? error,
    String? search,
    String? classId,
  }) {
    return StudentListState(
      students: students ?? this.students,
      meta: meta ?? this.meta,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      search: search ?? this.search,
      classId: classId ?? this.classId,
    );
  }
}

class StudentListController extends StateNotifier<StudentListState> {
  final StudentRepository _repository;

  StudentListController(this._repository) : super(const StudentListState());

  Future<void> loadStudents({int page = 1}) async {
    state = state.copyWith(isLoading: true, error: null, meta: state.meta.copyWith(page: page));
    try {
      final result = await _repository.getStudents(
        page: page,
        search: state.search,
        classId: state.classId,
      );
      state = state.copyWith(
        students: result.students,
        meta: result.meta,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void setSearch(String query) {
    state = state.copyWith(search: query.isEmpty ? null : query);
    loadStudents();
  }

  void setClassId(String? classId) {
    state = state.copyWith(classId: classId);
    loadStudents();
  }
}

final studentListControllerProvider =
    StateNotifierProvider<StudentListController, StudentListState>((ref) {
  final dio = ref.read(dioClientProvider);
  final repo = StudentRepository(dio);
  return StudentListController(repo);
});
