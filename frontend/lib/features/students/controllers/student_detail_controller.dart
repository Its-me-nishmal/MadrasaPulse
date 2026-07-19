import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_provider.dart';
import '../../../models/student.dart';
import '../repositories/student_repository.dart';

class StudentDetailState {
  final Student? student;
  final bool isLoading;
  final String? error;

  const StudentDetailState({this.student, this.isLoading = false, this.error});

  StudentDetailState copyWith({Student? student, bool? isLoading, String? error}) {
    return StudentDetailState(
      student: student ?? this.student,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class StudentDetailController extends StateNotifier<StudentDetailState> {
  final StudentRepository _repository;

  StudentDetailController(this._repository) : super(const StudentDetailState());

  Future<void> loadStudent(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final student = await _repository.getStudentById(id);
      state = state.copyWith(student: student, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final studentDetailControllerProvider =
    StateNotifierProvider.family<StudentDetailController, StudentDetailState, String>((ref, id) {
  final dio = ref.read(dioClientProvider);
  final repo = StudentRepository(dio);
  return StudentDetailController(repo);
});
