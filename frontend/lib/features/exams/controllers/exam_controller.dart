import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_provider.dart';
import '../repositories/exam_repository.dart';

class ExamControllerState {
  final bool isLoading;
  final String? error;
  const ExamControllerState({this.isLoading = false, this.error});
  ExamControllerState copyWith({bool? isLoading, String? error}) => ExamControllerState(isLoading: isLoading ?? this.isLoading, error: error ?? this.error);
}

class ExamController extends StateNotifier<ExamControllerState> {
  final ExamRepository _repo;
  ExamController(this._repo) : super(const ExamControllerState());
}

final examControllerProvider = StateNotifierProvider<ExamController, ExamControllerState>((ref) {
  final dio = ref.read(dioClientProvider);
  return ExamController(ExamRepository(dio));
});
