import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExamControllerState {
  final bool isLoading;
  final String? error;
  const ExamControllerState({this.isLoading = false, this.error});
  ExamControllerState copyWith({bool? isLoading, String? error}) => ExamControllerState(isLoading: isLoading ?? this.isLoading, error: error ?? this.error);
}

class ExamController extends StateNotifier<ExamControllerState> {
  ExamController() : super(const ExamControllerState());
}

final examControllerProvider = StateNotifierProvider<ExamController, ExamControllerState>((ref) {
  return ExamController();
});
