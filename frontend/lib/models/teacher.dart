import 'package:freezed_annotation/freezed_annotation.dart';

part 'teacher.freezed.dart';
part 'teacher.g.dart';

@freezed
class TeacherAssignment with _$TeacherAssignment {
  const factory TeacherAssignment({
    required String classId,
    required String subjectName,
  }) = _TeacherAssignment;

  factory TeacherAssignment.fromJson(Map<String, dynamic> json) => _$TeacherAssignmentFromJson(json);
}

Object? _readId(Map map, String key) => map['id'] ?? map['_id'];

@freezed
class Teacher with _$Teacher {
  const factory Teacher({
    @JsonKey(readValue: _readId) required String id,
    required String madrasaId,
    required String staffId,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String phone,
    String? email,
    @Default([]) List<String> qualifications,
    @Default([]) List<TeacherAssignment> assignedClasses,
    @Default(false) bool isDeleted,
    @Default('') String fullName,
  }) = _Teacher;

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);
}
