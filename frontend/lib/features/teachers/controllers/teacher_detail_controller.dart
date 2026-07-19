import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_provider.dart';
import '../../../models/teacher.dart';
import '../repositories/teacher_repository.dart';

class TeacherDetailState {
  final Teacher? teacher;
  final bool isLoading;
  final String? error;
  const TeacherDetailState({this.teacher, this.isLoading = false, this.error});
  TeacherDetailState copyWith({Teacher? teacher, bool? isLoading, String? error}) {
    return TeacherDetailState(teacher: teacher ?? this.teacher, isLoading: isLoading ?? this.isLoading, error: error ?? this.error);
  }
}

class TeacherDetailController extends StateNotifier<TeacherDetailState> {
  final TeacherRepository _repo;
  TeacherDetailController(this._repo) : super(const TeacherDetailState());

  Future<void> loadTeacher(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final teacher = await _repo.getTeacherById(id);
      state = state.copyWith(teacher: teacher, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final teacherDetailControllerProvider =
    StateNotifierProvider.family<TeacherDetailController, TeacherDetailState, String>((ref, id) {
  final dio = ref.read(dioClientProvider);
  return TeacherDetailController(TeacherRepository(dio));
});
