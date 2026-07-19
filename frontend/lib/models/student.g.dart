// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GuardianImpl _$$GuardianImplFromJson(Map<String, dynamic> json) =>
    _$GuardianImpl(
      name: json['name'] as String?,
      relationship: json['relationship'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      isPrimary: json['isPrimary'] as bool? ?? false,
    );

Map<String, dynamic> _$$GuardianImplToJson(_$GuardianImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'relationship': instance.relationship,
      'phone': instance.phone,
      'isPrimary': instance.isPrimary,
    };

_$StudentImpl _$$StudentImplFromJson(Map<String, dynamic> json) =>
    _$StudentImpl(
      id: json['id'] as String,
      madrasaId: json['madrasaId'] as String,
      admissionNo: json['admissionNo'] as String,
      rollNo: json['rollNo'] as String?,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      guardians: (json['guardians'] as List<dynamic>?)
              ?.map((e) => Guardian.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      dateOfBirth: json['dateOfBirth'] as String?,
      classId: json['classId'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      formattedName: json['formattedName'] as String? ?? '',
    );

Map<String, dynamic> _$$StudentImplToJson(_$StudentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'madrasaId': instance.madrasaId,
      'admissionNo': instance.admissionNo,
      'rollNo': instance.rollNo,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'guardians': instance.guardians,
      'dateOfBirth': instance.dateOfBirth,
      'classId': instance.classId,
      'isDeleted': instance.isDeleted,
      'formattedName': instance.formattedName,
    };
