import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam.freezed.dart';
part 'exam.g.dart';

@freezed
class StudentScore with _$StudentScore {
  const factory StudentScore({
    String? studentId,
    @Default(0) double marksObtained,
    @Default(0) double maxMarks,
    String? remarks,
  }) = _StudentScore;

  factory StudentScore.fromJson(Map<String, dynamic>? json) =>
      _$StudentScoreFromJson(json ?? {});
}

@freezed
class ExamRecord with _$ExamRecord {
  const factory ExamRecord({
    required String madrasaId,
    required String classId,
    required String examId,
    required String subjectName,
    @Default(100) double maxMarks,
    required List<StudentScore> records,
  }) = _ExamRecord;

  factory ExamRecord.fromJson(Map<String, dynamic>? json) =>
      _$ExamRecordFromJson(json ?? {});
}

@freezed
class ReportCardItem with _$ReportCardItem {
  const factory ReportCardItem({
    String? subjectName,
    double? maxMarks,
    double? marksObtained,
    double? percentage,
    String? grade,
  }) = _ReportCardItem;

  factory ReportCardItem.fromJson(Map<String, dynamic>? json) =>
      _$ReportCardItemFromJson(json ?? {});
}
