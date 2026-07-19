import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_provider.dart';
import '../../../models/student.dart';
import '../repositories/student_repository.dart';

class StudentFormState {
  final bool isSubmitting;
  final String? error;
  final Student? savedStudent;

  const StudentFormState({this.isSubmitting = false, this.error, this.savedStudent});

  StudentFormState copyWith({bool? isSubmitting, String? error, Student? savedStudent}) {
    return StudentFormState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error ?? this.error,
      savedStudent: savedStudent ?? this.savedStudent,
    );
  }
}

class StudentFormController extends StateNotifier<StudentFormState> {
  final StudentRepository _repository;

  StudentFormController(this._repository) : super(const StudentFormState());

  Future<bool> createStudent(Map<String, dynamic> data) async {
    state = state.copyWith(isSubmitting: true, error: null);
    try {
      final student = await _repository.createStudent(data);
      state = state.copyWith(isSubmitting: false, savedStudent: student);
      return true;
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: e.toString());
      return false;
    }
  }

  Future<bool> updateStudent(String id, Map<String, dynamic> data) async {
    state = state.copyWith(isSubmitting: true, error: null);
    try {
      final student = await _repository.updateStudent(id, data);
      state = state.copyWith(isSubmitting: false, savedStudent: student);
      return true;
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: e.toString());
      return false;
    }
  }
}

final studentFormControllerProvider =
    StateNotifierProvider<StudentFormController, StudentFormState>((ref) {
  final dio = ref.read(dioClientProvider);
  final repo = StudentRepository(dio);
  return StudentFormController(repo);
});
