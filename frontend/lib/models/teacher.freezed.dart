// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teacher.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TeacherAssignment _$TeacherAssignmentFromJson(Map<String, dynamic> json) {
  return _TeacherAssignment.fromJson(json);
}

/// @nodoc
mixin _$TeacherAssignment {
  String get classId => throw _privateConstructorUsedError;
  String get subjectName => throw _privateConstructorUsedError;

  /// Serializes this TeacherAssignment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeacherAssignment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeacherAssignmentCopyWith<TeacherAssignment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeacherAssignmentCopyWith<$Res> {
  factory $TeacherAssignmentCopyWith(
          TeacherAssignment value, $Res Function(TeacherAssignment) then) =
      _$TeacherAssignmentCopyWithImpl<$Res, TeacherAssignment>;
  @useResult
  $Res call({String classId, String subjectName});
}

/// @nodoc
class _$TeacherAssignmentCopyWithImpl<$Res, $Val extends TeacherAssignment>
    implements $TeacherAssignmentCopyWith<$Res> {
  _$TeacherAssignmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeacherAssignment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classId = null,
    Object? subjectName = null,
  }) {
    return _then(_value.copyWith(
      classId: null == classId
          ? _value.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String,
      subjectName: null == subjectName
          ? _value.subjectName
          : subjectName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeacherAssignmentImplCopyWith<$Res>
    implements $TeacherAssignmentCopyWith<$Res> {
  factory _$$TeacherAssignmentImplCopyWith(_$TeacherAssignmentImpl value,
          $Res Function(_$TeacherAssignmentImpl) then) =
      __$$TeacherAssignmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String classId, String subjectName});
}

/// @nodoc
class __$$TeacherAssignmentImplCopyWithImpl<$Res>
    extends _$TeacherAssignmentCopyWithImpl<$Res, _$TeacherAssignmentImpl>
    implements _$$TeacherAssignmentImplCopyWith<$Res> {
  __$$TeacherAssignmentImplCopyWithImpl(_$TeacherAssignmentImpl _value,
      $Res Function(_$TeacherAssignmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of TeacherAssignment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classId = null,
    Object? subjectName = null,
  }) {
    return _then(_$TeacherAssignmentImpl(
      classId: null == classId
          ? _value.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String,
      subjectName: null == subjectName
          ? _value.subjectName
          : subjectName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeacherAssignmentImpl implements _TeacherAssignment {
  const _$TeacherAssignmentImpl(
      {required this.classId, required this.subjectName});

  factory _$TeacherAssignmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeacherAssignmentImplFromJson(json);

  @override
  final String classId;
  @override
  final String subjectName;

  @override
  String toString() {
    return 'TeacherAssignment(classId: $classId, subjectName: $subjectName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeacherAssignmentImpl &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.subjectName, subjectName) ||
                other.subjectName == subjectName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, classId, subjectName);

  /// Create a copy of TeacherAssignment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeacherAssignmentImplCopyWith<_$TeacherAssignmentImpl> get copyWith =>
      __$$TeacherAssignmentImplCopyWithImpl<_$TeacherAssignmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeacherAssignmentImplToJson(
      this,
    );
  }
}

abstract class _TeacherAssignment implements TeacherAssignment {
  const factory _TeacherAssignment(
      {required final String classId,
      required final String subjectName}) = _$TeacherAssignmentImpl;

  factory _TeacherAssignment.fromJson(Map<String, dynamic> json) =
      _$TeacherAssignmentImpl.fromJson;

  @override
  String get classId;
  @override
  String get subjectName;

  /// Create a copy of TeacherAssignment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeacherAssignmentImplCopyWith<_$TeacherAssignmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Teacher _$TeacherFromJson(Map<String, dynamic> json) {
  return _Teacher.fromJson(json);
}

/// @nodoc
mixin _$Teacher {
  String get id => throw _privateConstructorUsedError;
  String get madrasaId => throw _privateConstructorUsedError;
  String get staffId => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  List<String> get qualifications => throw _privateConstructorUsedError;
  List<TeacherAssignment> get assignedClasses =>
      throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;

  /// Serializes this Teacher to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Teacher
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeacherCopyWith<Teacher> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeacherCopyWith<$Res> {
  factory $TeacherCopyWith(Teacher value, $Res Function(Teacher) then) =
      _$TeacherCopyWithImpl<$Res, Teacher>;
  @useResult
  $Res call(
      {String id,
      String madrasaId,
      String staffId,
      String firstName,
      String lastName,
      String phone,
      String? email,
      List<String> qualifications,
      List<TeacherAssignment> assignedClasses,
      bool isDeleted,
      String fullName});
}

/// @nodoc
class _$TeacherCopyWithImpl<$Res, $Val extends Teacher>
    implements $TeacherCopyWith<$Res> {
  _$TeacherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Teacher
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? madrasaId = null,
    Object? staffId = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = null,
    Object? email = freezed,
    Object? qualifications = null,
    Object? assignedClasses = null,
    Object? isDeleted = null,
    Object? fullName = null,
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
      staffId: null == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      qualifications: null == qualifications
          ? _value.qualifications
          : qualifications // ignore: cast_nullable_to_non_nullable
              as List<String>,
      assignedClasses: null == assignedClasses
          ? _value.assignedClasses
          : assignedClasses // ignore: cast_nullable_to_non_nullable
              as List<TeacherAssignment>,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeacherImplCopyWith<$Res> implements $TeacherCopyWith<$Res> {
  factory _$$TeacherImplCopyWith(
          _$TeacherImpl value, $Res Function(_$TeacherImpl) then) =
      __$$TeacherImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String madrasaId,
      String staffId,
      String firstName,
      String lastName,
      String phone,
      String? email,
      List<String> qualifications,
      List<TeacherAssignment> assignedClasses,
      bool isDeleted,
      String fullName});
}

/// @nodoc
class __$$TeacherImplCopyWithImpl<$Res>
    extends _$TeacherCopyWithImpl<$Res, _$TeacherImpl>
    implements _$$TeacherImplCopyWith<$Res> {
  __$$TeacherImplCopyWithImpl(
      _$TeacherImpl _value, $Res Function(_$TeacherImpl) _then)
      : super(_value, _then);

  /// Create a copy of Teacher
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? madrasaId = null,
    Object? staffId = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = null,
    Object? email = freezed,
    Object? qualifications = null,
    Object? assignedClasses = null,
    Object? isDeleted = null,
    Object? fullName = null,
  }) {
    return _then(_$TeacherImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      madrasaId: null == madrasaId
          ? _value.madrasaId
          : madrasaId // ignore: cast_nullable_to_non_nullable
              as String,
      staffId: null == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      qualifications: null == qualifications
          ? _value._qualifications
          : qualifications // ignore: cast_nullable_to_non_nullable
              as List<String>,
      assignedClasses: null == assignedClasses
          ? _value._assignedClasses
          : assignedClasses // ignore: cast_nullable_to_non_nullable
              as List<TeacherAssignment>,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeacherImpl implements _Teacher {
  const _$TeacherImpl(
      {required this.id,
      required this.madrasaId,
      required this.staffId,
      this.firstName = '',
      this.lastName = '',
      this.phone = '',
      this.email,
      final List<String> qualifications = const [],
      final List<TeacherAssignment> assignedClasses = const [],
      this.isDeleted = false,
      this.fullName = ''})
      : _qualifications = qualifications,
        _assignedClasses = assignedClasses;

  factory _$TeacherImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeacherImplFromJson(json);

  @override
  final String id;
  @override
  final String madrasaId;
  @override
  final String staffId;
  @override
  @JsonKey()
  final String firstName;
  @override
  @JsonKey()
  final String lastName;
  @override
  @JsonKey()
  final String phone;
  @override
  final String? email;
  final List<String> _qualifications;
  @override
  @JsonKey()
  List<String> get qualifications {
    if (_qualifications is EqualUnmodifiableListView) return _qualifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_qualifications);
  }

  final List<TeacherAssignment> _assignedClasses;
  @override
  @JsonKey()
  List<TeacherAssignment> get assignedClasses {
    if (_assignedClasses is EqualUnmodifiableListView) return _assignedClasses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignedClasses);
  }

  @override
  @JsonKey()
  final bool isDeleted;
  @override
  @JsonKey()
  final String fullName;

  @override
  String toString() {
    return 'Teacher(id: $id, madrasaId: $madrasaId, staffId: $staffId, firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, qualifications: $qualifications, assignedClasses: $assignedClasses, isDeleted: $isDeleted, fullName: $fullName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeacherImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.madrasaId, madrasaId) ||
                other.madrasaId == madrasaId) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality()
                .equals(other._qualifications, _qualifications) &&
            const DeepCollectionEquality()
                .equals(other._assignedClasses, _assignedClasses) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      madrasaId,
      staffId,
      firstName,
      lastName,
      phone,
      email,
      const DeepCollectionEquality().hash(_qualifications),
      const DeepCollectionEquality().hash(_assignedClasses),
      isDeleted,
      fullName);

  /// Create a copy of Teacher
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeacherImplCopyWith<_$TeacherImpl> get copyWith =>
      __$$TeacherImplCopyWithImpl<_$TeacherImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeacherImplToJson(
      this,
    );
  }
}

abstract class _Teacher implements Teacher {
  const factory _Teacher(
      {required final String id,
      required final String madrasaId,
      required final String staffId,
      final String firstName,
      final String lastName,
      final String phone,
      final String? email,
      final List<String> qualifications,
      final List<TeacherAssignment> assignedClasses,
      final bool isDeleted,
      final String fullName}) = _$TeacherImpl;

  factory _Teacher.fromJson(Map<String, dynamic> json) = _$TeacherImpl.fromJson;

  @override
  String get id;
  @override
  String get madrasaId;
  @override
  String get staffId;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get phone;
  @override
  String? get email;
  @override
  List<String> get qualifications;
  @override
  List<TeacherAssignment> get assignedClasses;
  @override
  bool get isDeleted;
  @override
  String get fullName;

  /// Create a copy of Teacher
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeacherImplCopyWith<_$TeacherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
