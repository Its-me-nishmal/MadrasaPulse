import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance.freezed.dart';
part 'attendance.g.dart';

@freezed
class AttendanceRecord with _$AttendanceRecord {
  const factory AttendanceRecord({
    String? studentId,
    @Default('Present') String status,
    String? note,
  }) = _AttendanceRecord;

  factory AttendanceRecord.fromJson(Map<String, dynamic>? json) =>
      _$AttendanceRecordFromJson(json ?? {});
}

@freezed
class DailyLog with _$DailyLog {
  const factory DailyLog({
    required int day,
    String? submittedBy,
    required List<AttendanceRecord> records,
  }) = _DailyLog;

  factory DailyLog.fromJson(Map<String, dynamic>? json) =>
      _$DailyLogFromJson(json ?? {});
}

@freezed
class AttendanceBucket with _$AttendanceBucket {
  const factory AttendanceBucket({
    required String madrasaId,
    required String classId,
    required String monthYear,
    @Default([]) List<DailyLog> dailyLogs,
  }) = _AttendanceBucket;

  factory AttendanceBucket.fromJson(Map<String, dynamic>? json) =>
      _$AttendanceBucketFromJson(json ?? {});
}

@freezed
class AttendanceSummary with _$AttendanceSummary {
  const factory AttendanceSummary({
    @Default(0) int totalDaysLogged,
    @Default(0) double attendanceRate,
    @Default(Amounts()) Amounts counts,
  }) = _AttendanceSummary;

  factory AttendanceSummary.fromJson(Map<String, dynamic>? json) =>
      _$AttendanceSummaryFromJson(json ?? {});
}

@freezed
class Amounts with _$Amounts {
  const factory Amounts({
    @Default(0) @JsonKey(name: 'Present') int present,
    @Default(0) @JsonKey(name: 'Absent') int absent,
    @Default(0) @JsonKey(name: 'Late') int late,
    @Default(0) @JsonKey(name: 'Excused') int excused,
  }) = _Amounts;

  factory Amounts.fromJson(Map<String, dynamic>? json) =>
      _$AmountsFromJson(json ?? {});
}
