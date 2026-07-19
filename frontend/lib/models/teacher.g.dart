// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeacherAssignmentImpl _$$TeacherAssignmentImplFromJson(
        Map<String, dynamic> json) =>
    _$TeacherAssignmentImpl(
      classId: json['classId'] as String,
      subjectName: json['subjectName'] as String,
    );

Map<String, dynamic> _$$TeacherAssignmentImplToJson(
        _$TeacherAssignmentImpl instance) =>
    <String, dynamic>{
      'classId': instance.classId,
      'subjectName': instance.subjectName,
    };

_$TeacherImpl _$$TeacherImplFromJson(Map<String, dynamic> json) =>
    _$TeacherImpl(
      id: _readId(json, 'id') as String,
      madrasaId: json['madrasaId'] as String,
      staffId: json['staffId'] as String,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String?,
      qualifications: (json['qualifications'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      assignedClasses: (json['assignedClasses'] as List<dynamic>?)
              ?.map(
                  (e) => TeacherAssignment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isDeleted: json['isDeleted'] as bool? ?? false,
      fullName: json['fullName'] as String? ?? '',
    );

Map<String, dynamic> _$$TeacherImplToJson(_$TeacherImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'madrasaId': instance.madrasaId,
      'staffId': instance.staffId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'qualifications': instance.qualifications,
      'assignedClasses': instance.assignedClasses,
      'isDeleted': instance.isDeleted,
      'fullName': instance.fullName,
    };
