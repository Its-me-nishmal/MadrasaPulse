import 'package:freezed_annotation/freezed_annotation.dart';

part 'student.freezed.dart';
part 'student.g.dart';

@freezed
class Guardian with _$Guardian {
  const factory Guardian({
    String? name,
    @Default('') String relationship,
    @Default('') String phone,
    @Default(false) bool isPrimary,
  }) = _Guardian;

  factory Guardian.fromJson(Map<String, dynamic> json) => _$GuardianFromJson(json);
}

@freezed
class Student with _$Student {
  const factory Student({
    required String id,
    required String madrasaId,
    required String admissionNo,
    String? rollNo,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default([]) List<Guardian> guardians,
    String? dateOfBirth,
    String? classId,
    @Default(false) bool isDeleted,
    @Default('') String formattedName,
  }) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null && json['_id'] != null) {
      json = {...json, 'id': json['_id']};
    }
    return _$StudentFromJson(json);
  }
}
