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

Object? _readId(Map map, String key) => map['id'] ?? map['_id'];

@freezed
class Student with _$Student {
  const factory Student({
    @JsonKey(readValue: _readId) required String id,
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

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
}
