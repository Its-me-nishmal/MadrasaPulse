// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceRecordImpl _$$AttendanceRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceRecordImpl(
      studentId: json['studentId'] as String?,
      status: json['status'] as String? ?? 'Present',
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$AttendanceRecordImplToJson(
        _$AttendanceRecordImpl instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'status': instance.status,
      'note': instance.note,
    };

_$DailyLogImpl _$$DailyLogImplFromJson(Map<String, dynamic> json) =>
    _$DailyLogImpl(
      day: (json['day'] as num).toInt(),
      submittedBy: json['submittedBy'] as String?,
      records: (json['records'] as List<dynamic>)
          .map((e) => AttendanceRecord.fromJson(e as Map<String, dynamic>?))
          .toList(),
    );

Map<String, dynamic> _$$DailyLogImplToJson(_$DailyLogImpl instance) =>
    <String, dynamic>{
      'day': instance.day,
      'submittedBy': instance.submittedBy,
      'records': instance.records,
    };

_$AttendanceBucketImpl _$$AttendanceBucketImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceBucketImpl(
      madrasaId: json['madrasaId'] as String,
      classId: json['classId'] as String,
      monthYear: json['monthYear'] as String,
      dailyLogs: (json['dailyLogs'] as List<dynamic>?)
              ?.map((e) => DailyLog.fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AttendanceBucketImplToJson(
        _$AttendanceBucketImpl instance) =>
    <String, dynamic>{
      'madrasaId': instance.madrasaId,
      'classId': instance.classId,
      'monthYear': instance.monthYear,
      'dailyLogs': instance.dailyLogs,
    };

_$AttendanceSummaryImpl _$$AttendanceSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceSummaryImpl(
      totalDaysLogged: (json['totalDaysLogged'] as num?)?.toInt() ?? 0,
      attendanceRate: (json['attendanceRate'] as num?)?.toDouble() ?? 0,
      counts: json['counts'] == null
          ? const Amounts()
          : Amounts.fromJson(json['counts'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$AttendanceSummaryImplToJson(
        _$AttendanceSummaryImpl instance) =>
    <String, dynamic>{
      'totalDaysLogged': instance.totalDaysLogged,
      'attendanceRate': instance.attendanceRate,
      'counts': instance.counts,
    };

_$AmountsImpl _$$AmountsImplFromJson(Map<String, dynamic> json) =>
    _$AmountsImpl(
      present: (json['Present'] as num?)?.toInt() ?? 0,
      absent: (json['Absent'] as num?)?.toInt() ?? 0,
      late: (json['Late'] as num?)?.toInt() ?? 0,
      excused: (json['Excused'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$AmountsImplToJson(_$AmountsImpl instance) =>
    <String, dynamic>{
      'Present': instance.present,
      'Absent': instance.absent,
      'Late': instance.late,
      'Excused': instance.excused,
    };
