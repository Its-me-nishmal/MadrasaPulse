// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exam.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StudentScore _$StudentScoreFromJson(Map<String, dynamic> json) {
  return _StudentScore.fromJson(json);
}

/// @nodoc
mixin _$StudentScore {
  String? get studentId => throw _privateConstructorUsedError;
  double get marksObtained => throw _privateConstructorUsedError;
  double get maxMarks => throw _privateConstructorUsedError;
  String? get remarks => throw _privateConstructorUsedError;

  /// Serializes this StudentScore to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudentScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentScoreCopyWith<StudentScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentScoreCopyWith<$Res> {
  factory $StudentScoreCopyWith(
          StudentScore value, $Res Function(StudentScore) then) =
      _$StudentScoreCopyWithImpl<$Res, StudentScore>;
  @useResult
  $Res call(
      {String? studentId,
      double marksObtained,
      double maxMarks,
      String? remarks});
}

/// @nodoc
class _$StudentScoreCopyWithImpl<$Res, $Val extends StudentScore>
    implements $StudentScoreCopyWith<$Res> {
  _$StudentScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = freezed,
    Object? marksObtained = null,
    Object? maxMarks = null,
    Object? remarks = freezed,
  }) {
    return _then(_value.copyWith(
      studentId: freezed == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      marksObtained: null == marksObtained
          ? _value.marksObtained
          : marksObtained // ignore: cast_nullable_to_non_nullable
              as double,
      maxMarks: null == maxMarks
          ? _value.maxMarks
          : maxMarks // ignore: cast_nullable_to_non_nullable
              as double,
      remarks: freezed == remarks
          ? _value.remarks
          : remarks // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudentScoreImplCopyWith<$Res>
    implements $StudentScoreCopyWith<$Res> {
  factory _$$StudentScoreImplCopyWith(
          _$StudentScoreImpl value, $Res Function(_$StudentScoreImpl) then) =
      __$$StudentScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? studentId,
      double marksObtained,
      double maxMarks,
      String? remarks});
}

/// @nodoc
class __$$StudentScoreImplCopyWithImpl<$Res>
    extends _$StudentScoreCopyWithImpl<$Res, _$StudentScoreImpl>
    implements _$$StudentScoreImplCopyWith<$Res> {
  __$$StudentScoreImplCopyWithImpl(
      _$StudentScoreImpl _value, $Res Function(_$StudentScoreImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = freezed,
    Object? marksObtained = null,
    Object? maxMarks = null,
    Object? remarks = freezed,
  }) {
    return _then(_$StudentScoreImpl(
      studentId: freezed == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      marksObtained: null == marksObtained
          ? _value.marksObtained
          : marksObtained // ignore: cast_nullable_to_non_nullable
              as double,
      maxMarks: null == maxMarks
          ? _value.maxMarks
          : maxMarks // ignore: cast_nullable_to_non_nullable
              as double,
      remarks: freezed == remarks
          ? _value.remarks
          : remarks // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentScoreImpl implements _StudentScore {
  const _$StudentScoreImpl(
      {this.studentId,
      this.marksObtained = 0,
      this.maxMarks = 0,
      this.remarks});

  factory _$StudentScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentScoreImplFromJson(json);

  @override
  final String? studentId;
  @override
  @JsonKey()
  final double marksObtained;
  @override
  @JsonKey()
  final double maxMarks;
  @override
  final String? remarks;

  @override
  String toString() {
    return 'StudentScore(studentId: $studentId, marksObtained: $marksObtained, maxMarks: $maxMarks, remarks: $remarks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentScoreImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.marksObtained, marksObtained) ||
                other.marksObtained == marksObtained) &&
            (identical(other.maxMarks, maxMarks) ||
                other.maxMarks == maxMarks) &&
            (identical(other.remarks, remarks) || other.remarks == remarks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, studentId, marksObtained, maxMarks, remarks);

  /// Create a copy of StudentScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentScoreImplCopyWith<_$StudentScoreImpl> get copyWith =>
      __$$StudentScoreImplCopyWithImpl<_$StudentScoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentScoreImplToJson(
      this,
    );
  }
}

abstract class _StudentScore implements StudentScore {
  const factory _StudentScore(
      {final String? studentId,
      final double marksObtained,
      final double maxMarks,
      final String? remarks}) = _$StudentScoreImpl;

  factory _StudentScore.fromJson(Map<String, dynamic> json) =
      _$StudentScoreImpl.fromJson;

  @override
  String? get studentId;
  @override
  double get marksObtained;
  @override
  double get maxMarks;
  @override
  String? get remarks;

  /// Create a copy of StudentScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentScoreImplCopyWith<_$StudentScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExamRecord _$ExamRecordFromJson(Map<String, dynamic> json) {
  return _ExamRecord.fromJson(json);
}

/// @nodoc
mixin _$ExamRecord {
  String get madrasaId => throw _privateConstructorUsedError;
  String get classId => throw _privateConstructorUsedError;
  String get examId => throw _privateConstructorUsedError;
  String get subjectName => throw _privateConstructorUsedError;
  double get maxMarks => throw _privateConstructorUsedError;
  List<StudentScore> get records => throw _privateConstructorUsedError;

  /// Serializes this ExamRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExamRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExamRecordCopyWith<ExamRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExamRecordCopyWith<$Res> {
  factory $ExamRecordCopyWith(
          ExamRecord value, $Res Function(ExamRecord) then) =
      _$ExamRecordCopyWithImpl<$Res, ExamRecord>;
  @useResult
  $Res call(
      {String madrasaId,
      String classId,
      String examId,
      String subjectName,
      double maxMarks,
      List<StudentScore> records});
}

/// @nodoc
class _$ExamRecordCopyWithImpl<$Res, $Val extends ExamRecord>
    implements $ExamRecordCopyWith<$Res> {
  _$ExamRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExamRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? madrasaId = null,
    Object? classId = null,
    Object? examId = null,
    Object? subjectName = null,
    Object? maxMarks = null,
    Object? records = null,
  }) {
    return _then(_value.copyWith(
      madrasaId: null == madrasaId
          ? _value.madrasaId
          : madrasaId // ignore: cast_nullable_to_non_nullable
              as String,
      classId: null == classId
          ? _value.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String,
      examId: null == examId
          ? _value.examId
          : examId // ignore: cast_nullable_to_non_nullable
              as String,
      subjectName: null == subjectName
          ? _value.subjectName
          : subjectName // ignore: cast_nullable_to_non_nullable
              as String,
      maxMarks: null == maxMarks
          ? _value.maxMarks
          : maxMarks // ignore: cast_nullable_to_non_nullable
              as double,
      records: null == records
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<StudentScore>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExamRecordImplCopyWith<$Res>
    implements $ExamRecordCopyWith<$Res> {
  factory _$$ExamRecordImplCopyWith(
          _$ExamRecordImpl value, $Res Function(_$ExamRecordImpl) then) =
      __$$ExamRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String madrasaId,
      String classId,
      String examId,
      String subjectName,
      double maxMarks,
      List<StudentScore> records});
}

/// @nodoc
class __$$ExamRecordImplCopyWithImpl<$Res>
    extends _$ExamRecordCopyWithImpl<$Res, _$ExamRecordImpl>
    implements _$$ExamRecordImplCopyWith<$Res> {
  __$$ExamRecordImplCopyWithImpl(
      _$ExamRecordImpl _value, $Res Function(_$ExamRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExamRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? madrasaId = null,
    Object? classId = null,
    Object? examId = null,
    Object? subjectName = null,
    Object? maxMarks = null,
    Object? records = null,
  }) {
    return _then(_$ExamRecordImpl(
      madrasaId: null == madrasaId
          ? _value.madrasaId
          : madrasaId // ignore: cast_nullable_to_non_nullable
              as String,
      classId: null == classId
          ? _value.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String,
      examId: null == examId
          ? _value.examId
          : examId // ignore: cast_nullable_to_non_nullable
              as String,
      subjectName: null == subjectName
          ? _value.subjectName
          : subjectName // ignore: cast_nullable_to_non_nullable
              as String,
      maxMarks: null == maxMarks
          ? _value.maxMarks
          : maxMarks // ignore: cast_nullable_to_non_nullable
              as double,
      records: null == records
          ? _value._records
          : records // ignore: cast_nullable_to_non_nullable
              as List<StudentScore>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExamRecordImpl implements _ExamRecord {
  const _$ExamRecordImpl(
      {required this.madrasaId,
      required this.classId,
      required this.examId,
      required this.subjectName,
      this.maxMarks = 100,
      required final List<StudentScore> records})
      : _records = records;

  factory _$ExamRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExamRecordImplFromJson(json);

  @override
  final String madrasaId;
  @override
  final String classId;
  @override
  final String examId;
  @override
  final String subjectName;
  @override
  @JsonKey()
  final double maxMarks;
  final List<StudentScore> _records;
  @override
  List<StudentScore> get records {
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_records);
  }

  @override
  String toString() {
    return 'ExamRecord(madrasaId: $madrasaId, classId: $classId, examId: $examId, subjectName: $subjectName, maxMarks: $maxMarks, records: $records)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExamRecordImpl &&
            (identical(other.madrasaId, madrasaId) ||
                other.madrasaId == madrasaId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.examId, examId) || other.examId == examId) &&
            (identical(other.subjectName, subjectName) ||
                other.subjectName == subjectName) &&
            (identical(other.maxMarks, maxMarks) ||
                other.maxMarks == maxMarks) &&
            const DeepCollectionEquality().equals(other._records, _records));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, madrasaId, classId, examId,
      subjectName, maxMarks, const DeepCollectionEquality().hash(_records));

  /// Create a copy of ExamRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExamRecordImplCopyWith<_$ExamRecordImpl> get copyWith =>
      __$$ExamRecordImplCopyWithImpl<_$ExamRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExamRecordImplToJson(
      this,
    );
  }
}

abstract class _ExamRecord implements ExamRecord {
  const factory _ExamRecord(
      {required final String madrasaId,
      required final String classId,
      required final String examId,
      required final String subjectName,
      final double maxMarks,
      required final List<StudentScore> records}) = _$ExamRecordImpl;

  factory _ExamRecord.fromJson(Map<String, dynamic> json) =
      _$ExamRecordImpl.fromJson;

  @override
  String get madrasaId;
  @override
  String get classId;
  @override
  String get examId;
  @override
  String get subjectName;
  @override
  double get maxMarks;
  @override
  List<StudentScore> get records;

  /// Create a copy of ExamRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExamRecordImplCopyWith<_$ExamRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReportCardItem _$ReportCardItemFromJson(Map<String, dynamic> json) {
  return _ReportCardItem.fromJson(json);
}

/// @nodoc
mixin _$ReportCardItem {
  String? get subjectName => throw _privateConstructorUsedError;
  double? get maxMarks => throw _privateConstructorUsedError;
  double? get marksObtained => throw _privateConstructorUsedError;
  double? get percentage => throw _privateConstructorUsedError;
  String? get grade => throw _privateConstructorUsedError;

  /// Serializes this ReportCardItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReportCardItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportCardItemCopyWith<ReportCardItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportCardItemCopyWith<$Res> {
  factory $ReportCardItemCopyWith(
          ReportCardItem value, $Res Function(ReportCardItem) then) =
      _$ReportCardItemCopyWithImpl<$Res, ReportCardItem>;
  @useResult
  $Res call(
      {String? subjectName,
      double? maxMarks,
      double? marksObtained,
      double? percentage,
      String? grade});
}

/// @nodoc
class _$ReportCardItemCopyWithImpl<$Res, $Val extends ReportCardItem>
    implements $ReportCardItemCopyWith<$Res> {
  _$ReportCardItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportCardItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subjectName = freezed,
    Object? maxMarks = freezed,
    Object? marksObtained = freezed,
    Object? percentage = freezed,
    Object? grade = freezed,
  }) {
    return _then(_value.copyWith(
      subjectName: freezed == subjectName
          ? _value.subjectName
          : subjectName // ignore: cast_nullable_to_non_nullable
              as String?,
      maxMarks: freezed == maxMarks
          ? _value.maxMarks
          : maxMarks // ignore: cast_nullable_to_non_nullable
              as double?,
      marksObtained: freezed == marksObtained
          ? _value.marksObtained
          : marksObtained // ignore: cast_nullable_to_non_nullable
              as double?,
      percentage: freezed == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double?,
      grade: freezed == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportCardItemImplCopyWith<$Res>
    implements $ReportCardItemCopyWith<$Res> {
  factory _$$ReportCardItemImplCopyWith(_$ReportCardItemImpl value,
          $Res Function(_$ReportCardItemImpl) then) =
      __$$ReportCardItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? subjectName,
      double? maxMarks,
      double? marksObtained,
      double? percentage,
      String? grade});
}

/// @nodoc
class __$$ReportCardItemImplCopyWithImpl<$Res>
    extends _$ReportCardItemCopyWithImpl<$Res, _$ReportCardItemImpl>
    implements _$$ReportCardItemImplCopyWith<$Res> {
  __$$ReportCardItemImplCopyWithImpl(
      _$ReportCardItemImpl _value, $Res Function(_$ReportCardItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReportCardItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subjectName = freezed,
    Object? maxMarks = freezed,
    Object? marksObtained = freezed,
    Object? percentage = freezed,
    Object? grade = freezed,
  }) {
    return _then(_$ReportCardItemImpl(
      subjectName: freezed == subjectName
          ? _value.subjectName
          : subjectName // ignore: cast_nullable_to_non_nullable
              as String?,
      maxMarks: freezed == maxMarks
          ? _value.maxMarks
          : maxMarks // ignore: cast_nullable_to_non_nullable
              as double?,
      marksObtained: freezed == marksObtained
          ? _value.marksObtained
          : marksObtained // ignore: cast_nullable_to_non_nullable
              as double?,
      percentage: freezed == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double?,
      grade: freezed == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportCardItemImpl implements _ReportCardItem {
  const _$ReportCardItemImpl(
      {this.subjectName,
      this.maxMarks,
      this.marksObtained,
      this.percentage,
      this.grade});

  factory _$ReportCardItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportCardItemImplFromJson(json);

  @override
  final String? subjectName;
  @override
  final double? maxMarks;
  @override
  final double? marksObtained;
  @override
  final double? percentage;
  @override
  final String? grade;

  @override
  String toString() {
    return 'ReportCardItem(subjectName: $subjectName, maxMarks: $maxMarks, marksObtained: $marksObtained, percentage: $percentage, grade: $grade)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportCardItemImpl &&
            (identical(other.subjectName, subjectName) ||
                other.subjectName == subjectName) &&
            (identical(other.maxMarks, maxMarks) ||
                other.maxMarks == maxMarks) &&
            (identical(other.marksObtained, marksObtained) ||
                other.marksObtained == marksObtained) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.grade, grade) || other.grade == grade));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, subjectName, maxMarks, marksObtained, percentage, grade);

  /// Create a copy of ReportCardItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportCardItemImplCopyWith<_$ReportCardItemImpl> get copyWith =>
      __$$ReportCardItemImplCopyWithImpl<_$ReportCardItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportCardItemImplToJson(
      this,
    );
  }
}

abstract class _ReportCardItem implements ReportCardItem {
  const factory _ReportCardItem(
      {final String? subjectName,
      final double? maxMarks,
      final double? marksObtained,
      final double? percentage,
      final String? grade}) = _$ReportCardItemImpl;

  factory _ReportCardItem.fromJson(Map<String, dynamic> json) =
      _$ReportCardItemImpl.fromJson;

  @override
  String? get subjectName;
  @override
  double? get maxMarks;
  @override
  double? get marksObtained;
  @override
  double? get percentage;
  @override
  String? get grade;

  /// Create a copy of ReportCardItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportCardItemImplCopyWith<_$ReportCardItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
