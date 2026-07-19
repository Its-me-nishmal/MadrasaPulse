// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentScoreImpl _$$StudentScoreImplFromJson(Map<String, dynamic> json) =>
    _$StudentScoreImpl(
      studentId: json['studentId'] as String?,
      marksObtained: (json['marksObtained'] as num?)?.toDouble() ?? 0,
      maxMarks: (json['maxMarks'] as num?)?.toDouble() ?? 0,
      remarks: json['remarks'] as String?,
    );

Map<String, dynamic> _$$StudentScoreImplToJson(_$StudentScoreImpl instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'marksObtained': instance.marksObtained,
      'maxMarks': instance.maxMarks,
      'remarks': instance.remarks,
    };

_$ExamRecordImpl _$$ExamRecordImplFromJson(Map<String, dynamic> json) =>
    _$ExamRecordImpl(
      madrasaId: json['madrasaId'] as String,
      classId: json['classId'] as String,
      examId: json['examId'] as String,
      subjectName: json['subjectName'] as String,
      maxMarks: (json['maxMarks'] as num?)?.toDouble() ?? 100,
      records: (json['records'] as List<dynamic>)
          .map((e) => StudentScore.fromJson(e as Map<String, dynamic>?))
          .toList(),
    );

Map<String, dynamic> _$$ExamRecordImplToJson(_$ExamRecordImpl instance) =>
    <String, dynamic>{
      'madrasaId': instance.madrasaId,
      'classId': instance.classId,
      'examId': instance.examId,
      'subjectName': instance.subjectName,
      'maxMarks': instance.maxMarks,
      'records': instance.records,
    };

_$ReportCardItemImpl _$$ReportCardItemImplFromJson(Map<String, dynamic> json) =>
    _$ReportCardItemImpl(
      subjectName: json['subjectName'] as String?,
      maxMarks: (json['maxMarks'] as num?)?.toDouble(),
      marksObtained: (json['marksObtained'] as num?)?.toDouble(),
      percentage: (json['percentage'] as num?)?.toDouble(),
      grade: json['grade'] as String?,
    );

Map<String, dynamic> _$$ReportCardItemImplToJson(
        _$ReportCardItemImpl instance) =>
    <String, dynamic>{
      'subjectName': instance.subjectName,
      'maxMarks': instance.maxMarks,
      'marksObtained': instance.marksObtained,
      'percentage': instance.percentage,
      'grade': instance.grade,
    };
