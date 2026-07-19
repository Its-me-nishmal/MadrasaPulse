// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Guardian _$GuardianFromJson(Map<String, dynamic> json) {
  return _Guardian.fromJson(json);
}

/// @nodoc
mixin _$Guardian {
  String? get name => throw _privateConstructorUsedError;
  String get relationship => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  bool get isPrimary => throw _privateConstructorUsedError;

  /// Serializes this Guardian to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Guardian
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GuardianCopyWith<Guardian> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuardianCopyWith<$Res> {
  factory $GuardianCopyWith(Guardian value, $Res Function(Guardian) then) =
      _$GuardianCopyWithImpl<$Res, Guardian>;
  @useResult
  $Res call({String? name, String relationship, String phone, bool isPrimary});
}

/// @nodoc
class _$GuardianCopyWithImpl<$Res, $Val extends Guardian>
    implements $GuardianCopyWith<$Res> {
  _$GuardianCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Guardian
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? relationship = null,
    Object? phone = null,
    Object? isPrimary = null,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      relationship: null == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      isPrimary: null == isPrimary
          ? _value.isPrimary
          : isPrimary // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GuardianImplCopyWith<$Res>
    implements $GuardianCopyWith<$Res> {
  factory _$$GuardianImplCopyWith(
          _$GuardianImpl value, $Res Function(_$GuardianImpl) then) =
      __$$GuardianImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String relationship, String phone, bool isPrimary});
}

/// @nodoc
class __$$GuardianImplCopyWithImpl<$Res>
    extends _$GuardianCopyWithImpl<$Res, _$GuardianImpl>
    implements _$$GuardianImplCopyWith<$Res> {
  __$$GuardianImplCopyWithImpl(
      _$GuardianImpl _value, $Res Function(_$GuardianImpl) _then)
      : super(_value, _then);

  /// Create a copy of Guardian
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? relationship = null,
    Object? phone = null,
    Object? isPrimary = null,
  }) {
    return _then(_$GuardianImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      relationship: null == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      isPrimary: null == isPrimary
          ? _value.isPrimary
          : isPrimary // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GuardianImpl implements _Guardian {
  const _$GuardianImpl(
      {this.name,
      this.relationship = '',
      this.phone = '',
      this.isPrimary = false});

  factory _$GuardianImpl.fromJson(Map<String, dynamic> json) =>
      _$$GuardianImplFromJson(json);

  @override
  final String? name;
  @override
  @JsonKey()
  final String relationship;
  @override
  @JsonKey()
  final String phone;
  @override
  @JsonKey()
  final bool isPrimary;

  @override
  String toString() {
    return 'Guardian(name: $name, relationship: $relationship, phone: $phone, isPrimary: $isPrimary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuardianImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.relationship, relationship) ||
                other.relationship == relationship) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.isPrimary, isPrimary) ||
                other.isPrimary == isPrimary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, relationship, phone, isPrimary);

  /// Create a copy of Guardian
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GuardianImplCopyWith<_$GuardianImpl> get copyWith =>
      __$$GuardianImplCopyWithImpl<_$GuardianImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GuardianImplToJson(
      this,
    );
  }
}

abstract class _Guardian implements Guardian {
  const factory _Guardian(
      {final String? name,
      final String relationship,
      final String phone,
      final bool isPrimary}) = _$GuardianImpl;

  factory _Guardian.fromJson(Map<String, dynamic> json) =
      _$GuardianImpl.fromJson;

  @override
  String? get name;
  @override
  String get relationship;
  @override
  String get phone;
  @override
  bool get isPrimary;

  /// Create a copy of Guardian
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GuardianImplCopyWith<_$GuardianImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Student _$StudentFromJson(Map<String, dynamic> json) {
  return _Student.fromJson(json);
}

/// @nodoc
mixin _$Student {
  String get id => throw _privateConstructorUsedError;
  String get madrasaId => throw _privateConstructorUsedError;
  String get admissionNo => throw _privateConstructorUsedError;
  String? get rollNo => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  List<Guardian> get guardians => throw _privateConstructorUsedError;
  String? get dateOfBirth => throw _privateConstructorUsedError;
  String? get classId => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  String get formattedName => throw _privateConstructorUsedError;

  /// Serializes this Student to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentCopyWith<Student> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentCopyWith<$Res> {
  factory $StudentCopyWith(Student value, $Res Function(Student) then) =
      _$StudentCopyWithImpl<$Res, Student>;
  @useResult
  $Res call(
      {String id,
      String madrasaId,
      String admissionNo,
      String? rollNo,
      String firstName,
      String lastName,
      List<Guardian> guardians,
      String? dateOfBirth,
      String? classId,
      bool isDeleted,
      String formattedName});
}

/// @nodoc
class _$StudentCopyWithImpl<$Res, $Val extends Student>
    implements $StudentCopyWith<$Res> {
  _$StudentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? madrasaId = null,
    Object? admissionNo = null,
    Object? rollNo = freezed,
    Object? firstName = null,
    Object? lastName = null,
    Object? guardians = null,
    Object? dateOfBirth = freezed,
    Object? classId = freezed,
    Object? isDeleted = null,
    Object? formattedName = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      madrasaId: null == madrasaId
          ? _value.madrasaId
          : madrasaId // ignore: cast_nullable_to_non_nullable
              as String,
      admissionNo: null == admissionNo
          ? _value.admissionNo
          : admissionNo // ignore: cast_nullable_to_non_nullable
              as String,
      rollNo: freezed == rollNo
          ? _value.rollNo
          : rollNo // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      guardians: null == guardians
          ? _value.guardians
          : guardians // ignore: cast_nullable_to_non_nullable
              as List<Guardian>,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _value.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      formattedName: null == formattedName
          ? _value.formattedName
          : formattedName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudentImplCopyWith<$Res> implements $StudentCopyWith<$Res> {
  factory _$$StudentImplCopyWith(
          _$StudentImpl value, $Res Function(_$StudentImpl) then) =
      __$$StudentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String madrasaId,
      String admissionNo,
      String? rollNo,
      String firstName,
      String lastName,
      List<Guardian> guardians,
      String? dateOfBirth,
      String? classId,
      bool isDeleted,
      String formattedName});
}

/// @nodoc
class __$$StudentImplCopyWithImpl<$Res>
    extends _$StudentCopyWithImpl<$Res, _$StudentImpl>
    implements _$$StudentImplCopyWith<$Res> {
  __$$StudentImplCopyWithImpl(
      _$StudentImpl _value, $Res Function(_$StudentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? madrasaId = null,
    Object? admissionNo = null,
    Object? rollNo = freezed,
    Object? firstName = null,
    Object? lastName = null,
    Object? guardians = null,
    Object? dateOfBirth = freezed,
    Object? classId = freezed,
    Object? isDeleted = null,
    Object? formattedName = null,
  }) {
    return _then(_$StudentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      madrasaId: null == madrasaId
          ? _value.madrasaId
          : madrasaId // ignore: cast_nullable_to_non_nullable
              as String,
      admissionNo: null == admissionNo
          ? _value.admissionNo
          : admissionNo // ignore: cast_nullable_to_non_nullable
              as String,
      rollNo: freezed == rollNo
          ? _value.rollNo
          : rollNo // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      guardians: null == guardians
          ? _value._guardians
          : guardians // ignore: cast_nullable_to_non_nullable
              as List<Guardian>,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _value.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      formattedName: null == formattedName
          ? _value.formattedName
          : formattedName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentImpl implements _Student {
  const _$StudentImpl(
      {required this.id,
      required this.madrasaId,
      required this.admissionNo,
      this.rollNo,
      this.firstName = '',
      this.lastName = '',
      final List<Guardian> guardians = const [],
      this.dateOfBirth,
      this.classId,
      this.isDeleted = false,
      this.formattedName = ''})
      : _guardians = guardians;

  factory _$StudentImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentImplFromJson(json);

  @override
  final String id;
  @override
  final String madrasaId;
  @override
  final String admissionNo;
  @override
  final String? rollNo;
  @override
  @JsonKey()
  final String firstName;
  @override
  @JsonKey()
  final String lastName;
  final List<Guardian> _guardians;
  @override
  @JsonKey()
  List<Guardian> get guardians {
    if (_guardians is EqualUnmodifiableListView) return _guardians;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_guardians);
  }

  @override
  final String? dateOfBirth;
  @override
  final String? classId;
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  @JsonKey()
  final String formattedName;

  @override
  String toString() {
    return 'Student(id: $id, madrasaId: $madrasaId, admissionNo: $admissionNo, rollNo: $rollNo, firstName: $firstName, lastName: $lastName, guardians: $guardians, dateOfBirth: $dateOfBirth, classId: $classId, isDeleted: $isDeleted, formattedName: $formattedName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.madrasaId, madrasaId) ||
                other.madrasaId == madrasaId) &&
            (identical(other.admissionNo, admissionNo) ||
                other.admissionNo == admissionNo) &&
            (identical(other.rollNo, rollNo) || other.rollNo == rollNo) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            const DeepCollectionEquality()
                .equals(other._guardians, _guardians) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.formattedName, formattedName) ||
                other.formattedName == formattedName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      madrasaId,
      admissionNo,
      rollNo,
      firstName,
      lastName,
      const DeepCollectionEquality().hash(_guardians),
      dateOfBirth,
      classId,
      isDeleted,
      formattedName);

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentImplCopyWith<_$StudentImpl> get copyWith =>
      __$$StudentImplCopyWithImpl<_$StudentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentImplToJson(
      this,
    );
  }
}

abstract class _Student implements Student {
  const factory _Student(
      {required final String id,
      required final String madrasaId,
      required final String admissionNo,
      final String? rollNo,
      final String firstName,
      final String lastName,
      final List<Guardian> guardians,
      final String? dateOfBirth,
      final String? classId,
      final bool isDeleted,
      final String formattedName}) = _$StudentImpl;

  factory _Student.fromJson(Map<String, dynamic> json) = _$StudentImpl.fromJson;

  @override
  String get id;
  @override
  String get madrasaId;
  @override
  String get admissionNo;
  @override
  String? get rollNo;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  List<Guardian> get guardians;
  @override
  String? get dateOfBirth;
  @override
  String? get classId;
  @override
  bool get isDeleted;
  @override
  String get formattedName;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentImplCopyWith<_$StudentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
