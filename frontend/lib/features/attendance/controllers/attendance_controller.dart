import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/attendance.dart';
import '../../../core/network/dio_provider.dart';
import '../repositories/attendance_repository.dart';

class AttendanceControllerState {
  final AttendanceBucket? bucket;
  final AttendanceSummary? summary;
  final bool isLoading;
  final String? error;
  const AttendanceControllerState({this.bucket, this.summary, this.isLoading = false, this.error});

  AttendanceControllerState copyWith({AttendanceBucket? bucket, AttendanceSummary? summary, bool? isLoading, String? error}) {
    return AttendanceControllerState(bucket: bucket ?? this.bucket, summary: summary ?? this.summary, isLoading: isLoading ?? this.isLoading, error: error ?? this.error);
  }
}

class AttendanceController extends StateNotifier<AttendanceControllerState> {
  final AttendanceRepository _repo;
  AttendanceController(this._repo) : super(const AttendanceControllerState());
}

final attendanceControllerProvider = StateNotifierProvider<AttendanceController, AttendanceControllerState>((ref) {
  final dio = ref.read(dioClientProvider);
  return AttendanceController(AttendanceRepository(dio));
});
