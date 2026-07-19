// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AttendanceRecord _$AttendanceRecordFromJson(Map<String, dynamic> json) {
  return _AttendanceRecord.fromJson(json);
}

/// @nodoc
mixin _$AttendanceRecord {
  String? get studentId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this AttendanceRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceRecordCopyWith<AttendanceRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceRecordCopyWith<$Res> {
  factory $AttendanceRecordCopyWith(
          AttendanceRecord value, $Res Function(AttendanceRecord) then) =
      _$AttendanceRecordCopyWithImpl<$Res, AttendanceRecord>;
  @useResult
  $Res call({String? studentId, String status, String? note});
}

/// @nodoc
class _$AttendanceRecordCopyWithImpl<$Res, $Val extends AttendanceRecord>
    implements $AttendanceRecordCopyWith<$Res> {
  _$AttendanceRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = freezed,
    Object? status = null,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      studentId: freezed == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceRecordImplCopyWith<$Res>
    implements $AttendanceRecordCopyWith<$Res> {
  factory _$$AttendanceRecordImplCopyWith(_$AttendanceRecordImpl value,
          $Res Function(_$AttendanceRecordImpl) then) =
      __$$AttendanceRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? studentId, String status, String? note});
}

/// @nodoc
class __$$AttendanceRecordImplCopyWithImpl<$Res>
    extends _$AttendanceRecordCopyWithImpl<$Res, _$AttendanceRecordImpl>
    implements _$$AttendanceRecordImplCopyWith<$Res> {
  __$$AttendanceRecordImplCopyWithImpl(_$AttendanceRecordImpl _value,
      $Res Function(_$AttendanceRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of AttendanceRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = freezed,
    Object? status = null,
    Object? note = freezed,
  }) {
    return _then(_$AttendanceRecordImpl(
      studentId: freezed == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceRecordImpl implements _AttendanceRecord {
  const _$AttendanceRecordImpl(
      {this.studentId, this.status = 'Present', this.note});

  factory _$AttendanceRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceRecordImplFromJson(json);

  @override
  final String? studentId;
  @override
  @JsonKey()
  final String status;
  @override
  final String? note;

  @override
  String toString() {
    return 'AttendanceRecord(studentId: $studentId, status: $status, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceRecordImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, studentId, status, note);

  /// Create a copy of AttendanceRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceRecordImplCopyWith<_$AttendanceRecordImpl> get copyWith =>
      __$$AttendanceRecordImplCopyWithImpl<_$AttendanceRecordImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceRecordImplToJson(
      this,
    );
  }
}

abstract class _AttendanceRecord implements AttendanceRecord {
  const factory _AttendanceRecord(
      {final String? studentId,
      final String status,
      final String? note}) = _$AttendanceRecordImpl;

  factory _AttendanceRecord.fromJson(Map<String, dynamic> json) =
      _$AttendanceRecordImpl.fromJson;

  @override
  String? get studentId;
  @override
  String get status;
  @override
  String? get note;

  /// Create a copy of AttendanceRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceRecordImplCopyWith<_$AttendanceRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyLog _$DailyLogFromJson(Map<String, dynamic> json) {
  return _DailyLog.fromJson(json);
}

/// @nodoc
mixin _$DailyLog {
  int get day => throw _privateConstructorUsedError;
  String? get submittedBy => throw _privateConstructorUsedError;
  List<AttendanceRecord> get records => throw _privateConstructorUsedError;

  /// Serializes this DailyLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyLogCopyWith<DailyLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyLogCopyWith<$Res> {
  factory $DailyLogCopyWith(DailyLog value, $Res Function(DailyLog) then) =
      _$DailyLogCopyWithImpl<$Res, DailyLog>;
  @useResult
  $Res call({int day, String? submittedBy, List<AttendanceRecord> records});
}

/// @nodoc
class _$DailyLogCopyWithImpl<$Res, $Val extends DailyLog>
    implements $DailyLogCopyWith<$Res> {
  _$DailyLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? submittedBy = freezed,
    Object? records = null,
  }) {
    return _then(_value.copyWith(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      submittedBy: freezed == submittedBy
          ? _value.submittedBy
          : submittedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      records: null == records
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<AttendanceRecord>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyLogImplCopyWith<$Res>
    implements $DailyLogCopyWith<$Res> {
  factory _$$DailyLogImplCopyWith(
          _$DailyLogImpl value, $Res Function(_$DailyLogImpl) then) =
      __$$DailyLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int day, String? submittedBy, List<AttendanceRecord> records});
}

/// @nodoc
class __$$DailyLogImplCopyWithImpl<$Res>
    extends _$DailyLogCopyWithImpl<$Res, _$DailyLogImpl>
    implements _$$DailyLogImplCopyWith<$Res> {
  __$$DailyLogImplCopyWithImpl(
      _$DailyLogImpl _value, $Res Function(_$DailyLogImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? submittedBy = freezed,
    Object? records = null,
  }) {
    return _then(_$DailyLogImpl(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      submittedBy: freezed == submittedBy
          ? _value.submittedBy
          : submittedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      records: null == records
          ? _value._records
          : records // ignore: cast_nullable_to_non_nullable
              as List<AttendanceRecord>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyLogImpl implements _DailyLog {
  const _$DailyLogImpl(
      {required this.day,
      this.submittedBy,
      required final List<AttendanceRecord> records})
      : _records = records;

  factory _$DailyLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyLogImplFromJson(json);

  @override
  final int day;
  @override
  final String? submittedBy;
  final List<AttendanceRecord> _records;
  @override
  List<AttendanceRecord> get records {
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_records);
  }

  @override
  String toString() {
    return 'DailyLog(day: $day, submittedBy: $submittedBy, records: $records)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyLogImpl &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.submittedBy, submittedBy) ||
                other.submittedBy == submittedBy) &&
            const DeepCollectionEquality().equals(other._records, _records));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, day, submittedBy,
      const DeepCollectionEquality().hash(_records));

  /// Create a copy of DailyLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyLogImplCopyWith<_$DailyLogImpl> get copyWith =>
      __$$DailyLogImplCopyWithImpl<_$DailyLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyLogImplToJson(
      this,
    );
  }
}

abstract class _DailyLog implements DailyLog {
  const factory _DailyLog(
      {required final int day,
      final String? submittedBy,
      required final List<AttendanceRecord> records}) = _$DailyLogImpl;

  factory _DailyLog.fromJson(Map<String, dynamic> json) =
      _$DailyLogImpl.fromJson;

  @override
  int get day;
  @override
  String? get submittedBy;
  @override
  List<AttendanceRecord> get records;

  /// Create a copy of DailyLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyLogImplCopyWith<_$DailyLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttendanceBucket _$AttendanceBucketFromJson(Map<String, dynamic> json) {
  return _AttendanceBucket.fromJson(json);
}

/// @nodoc
mixin _$AttendanceBucket {
  String get madrasaId => throw _privateConstructorUsedError;
  String get classId => throw _privateConstructorUsedError;
  String get monthYear => throw _privateConstructorUsedError;
  List<DailyLog> get dailyLogs => throw _privateConstructorUsedError;

  /// Serializes this AttendanceBucket to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceBucket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceBucketCopyWith<AttendanceBucket> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceBucketCopyWith<$Res> {
  factory $AttendanceBucketCopyWith(
          AttendanceBucket value, $Res Function(AttendanceBucket) then) =
      _$AttendanceBucketCopyWithImpl<$Res, AttendanceBucket>;
  @useResult
  $Res call(
      {String madrasaId,
      String classId,
      String monthYear,
      List<DailyLog> dailyLogs});
}

/// @nodoc
class _$AttendanceBucketCopyWithImpl<$Res, $Val extends AttendanceBucket>
    implements $AttendanceBucketCopyWith<$Res> {
  _$AttendanceBucketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceBucket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? madrasaId = null,
    Object? classId = null,
    Object? monthYear = null,
    Object? dailyLogs = null,
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
      monthYear: null == monthYear
          ? _value.monthYear
          : monthYear // ignore: cast_nullable_to_non_nullable
              as String,
      dailyLogs: null == dailyLogs
          ? _value.dailyLogs
          : dailyLogs // ignore: cast_nullable_to_non_nullable
              as List<DailyLog>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceBucketImplCopyWith<$Res>
    implements $AttendanceBucketCopyWith<$Res> {
  factory _$$AttendanceBucketImplCopyWith(_$AttendanceBucketImpl value,
          $Res Function(_$AttendanceBucketImpl) then) =
      __$$AttendanceBucketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String madrasaId,
      String classId,
      String monthYear,
      List<DailyLog> dailyLogs});
}

/// @nodoc
class __$$AttendanceBucketImplCopyWithImpl<$Res>
    extends _$AttendanceBucketCopyWithImpl<$Res, _$AttendanceBucketImpl>
    implements _$$AttendanceBucketImplCopyWith<$Res> {
  __$$AttendanceBucketImplCopyWithImpl(_$AttendanceBucketImpl _value,
      $Res Function(_$AttendanceBucketImpl) _then)
      : super(_value, _then);

  /// Create a copy of AttendanceBucket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? madrasaId = null,
    Object? classId = null,
    Object? monthYear = null,
    Object? dailyLogs = null,
  }) {
    return _then(_$AttendanceBucketImpl(
      madrasaId: null == madrasaId
          ? _value.madrasaId
          : madrasaId // ignore: cast_nullable_to_non_nullable
              as String,
      classId: null == classId
          ? _value.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String,
      monthYear: null == monthYear
          ? _value.monthYear
          : monthYear // ignore: cast_nullable_to_non_nullable
              as String,
      dailyLogs: null == dailyLogs
          ? _value._dailyLogs
          : dailyLogs // ignore: cast_nullable_to_non_nullable
              as List<DailyLog>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceBucketImpl implements _AttendanceBucket {
  const _$AttendanceBucketImpl(
      {required this.madrasaId,
      required this.classId,
      required this.monthYear,
      final List<DailyLog> dailyLogs = const []})
      : _dailyLogs = dailyLogs;

  factory _$AttendanceBucketImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceBucketImplFromJson(json);

  @override
  final String madrasaId;
  @override
  final String classId;
  @override
  final String monthYear;
  final List<DailyLog> _dailyLogs;
  @override
  @JsonKey()
  List<DailyLog> get dailyLogs {
    if (_dailyLogs is EqualUnmodifiableListView) return _dailyLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyLogs);
  }

  @override
  String toString() {
    return 'AttendanceBucket(madrasaId: $madrasaId, classId: $classId, monthYear: $monthYear, dailyLogs: $dailyLogs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceBucketImpl &&
            (identical(other.madrasaId, madrasaId) ||
                other.madrasaId == madrasaId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.monthYear, monthYear) ||
                other.monthYear == monthYear) &&
            const DeepCollectionEquality()
                .equals(other._dailyLogs, _dailyLogs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, madrasaId, classId, monthYear,
      const DeepCollectionEquality().hash(_dailyLogs));

  /// Create a copy of AttendanceBucket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceBucketImplCopyWith<_$AttendanceBucketImpl> get copyWith =>
      __$$AttendanceBucketImplCopyWithImpl<_$AttendanceBucketImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceBucketImplToJson(
      this,
    );
  }
}

abstract class _AttendanceBucket implements AttendanceBucket {
  const factory _AttendanceBucket(
      {required final String madrasaId,
      required final String classId,
      required final String monthYear,
      final List<DailyLog> dailyLogs}) = _$AttendanceBucketImpl;

  factory _AttendanceBucket.fromJson(Map<String, dynamic> json) =
      _$AttendanceBucketImpl.fromJson;

  @override
  String get madrasaId;
  @override
  String get classId;
  @override
  String get monthYear;
  @override
  List<DailyLog> get dailyLogs;

  /// Create a copy of AttendanceBucket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceBucketImplCopyWith<_$AttendanceBucketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttendanceSummary _$AttendanceSummaryFromJson(Map<String, dynamic> json) {
  return _AttendanceSummary.fromJson(json);
}

/// @nodoc
mixin _$AttendanceSummary {
  int get totalDaysLogged => throw _privateConstructorUsedError;
  double get attendanceRate => throw _privateConstructorUsedError;
  Amounts get counts => throw _privateConstructorUsedError;

  /// Serializes this AttendanceSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceSummaryCopyWith<AttendanceSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceSummaryCopyWith<$Res> {
  factory $AttendanceSummaryCopyWith(
          AttendanceSummary value, $Res Function(AttendanceSummary) then) =
      _$AttendanceSummaryCopyWithImpl<$Res, AttendanceSummary>;
  @useResult
  $Res call({int totalDaysLogged, double attendanceRate, Amounts counts});

  $AmountsCopyWith<$Res> get counts;
}

/// @nodoc
class _$AttendanceSummaryCopyWithImpl<$Res, $Val extends AttendanceSummary>
    implements $AttendanceSummaryCopyWith<$Res> {
  _$AttendanceSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalDaysLogged = null,
    Object? attendanceRate = null,
    Object? counts = null,
  }) {
    return _then(_value.copyWith(
      totalDaysLogged: null == totalDaysLogged
          ? _value.totalDaysLogged
          : totalDaysLogged // ignore: cast_nullable_to_non_nullable
              as int,
      attendanceRate: null == attendanceRate
          ? _value.attendanceRate
          : attendanceRate // ignore: cast_nullable_to_non_nullable
              as double,
      counts: null == counts
          ? _value.counts
          : counts // ignore: cast_nullable_to_non_nullable
              as Amounts,
    ) as $Val);
  }

  /// Create a copy of AttendanceSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AmountsCopyWith<$Res> get counts {
    return $AmountsCopyWith<$Res>(_value.counts, (value) {
      return _then(_value.copyWith(counts: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AttendanceSummaryImplCopyWith<$Res>
    implements $AttendanceSummaryCopyWith<$Res> {
  factory _$$AttendanceSummaryImplCopyWith(_$AttendanceSummaryImpl value,
          $Res Function(_$AttendanceSummaryImpl) then) =
      __$$AttendanceSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int totalDaysLogged, double attendanceRate, Amounts counts});

  @override
  $AmountsCopyWith<$Res> get counts;
}

/// @nodoc
class __$$AttendanceSummaryImplCopyWithImpl<$Res>
    extends _$AttendanceSummaryCopyWithImpl<$Res, _$AttendanceSummaryImpl>
    implements _$$AttendanceSummaryImplCopyWith<$Res> {
  __$$AttendanceSummaryImplCopyWithImpl(_$AttendanceSummaryImpl _value,
      $Res Function(_$AttendanceSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of AttendanceSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalDaysLogged = null,
    Object? attendanceRate = null,
    Object? counts = null,
  }) {
    return _then(_$AttendanceSummaryImpl(
      totalDaysLogged: null == totalDaysLogged
          ? _value.totalDaysLogged
          : totalDaysLogged // ignore: cast_nullable_to_non_nullable
              as int,
      attendanceRate: null == attendanceRate
          ? _value.attendanceRate
          : attendanceRate // ignore: cast_nullable_to_non_nullable
              as double,
      counts: null == counts
          ? _value.counts
          : counts // ignore: cast_nullable_to_non_nullable
              as Amounts,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceSummaryImpl implements _AttendanceSummary {
  const _$AttendanceSummaryImpl(
      {this.totalDaysLogged = 0,
      this.attendanceRate = 0,
      this.counts = const Amounts()});

  factory _$AttendanceSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceSummaryImplFromJson(json);

  @override
  @JsonKey()
  final int totalDaysLogged;
  @override
  @JsonKey()
  final double attendanceRate;
  @override
  @JsonKey()
  final Amounts counts;

  @override
  String toString() {
    return 'AttendanceSummary(totalDaysLogged: $totalDaysLogged, attendanceRate: $attendanceRate, counts: $counts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceSummaryImpl &&
            (identical(other.totalDaysLogged, totalDaysLogged) ||
                other.totalDaysLogged == totalDaysLogged) &&
            (identical(other.attendanceRate, attendanceRate) ||
                other.attendanceRate == attendanceRate) &&
            (identical(other.counts, counts) || other.counts == counts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, totalDaysLogged, attendanceRate, counts);

  /// Create a copy of AttendanceSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceSummaryImplCopyWith<_$AttendanceSummaryImpl> get copyWith =>
      __$$AttendanceSummaryImplCopyWithImpl<_$AttendanceSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceSummaryImplToJson(
      this,
    );
  }
}

abstract class _AttendanceSummary implements AttendanceSummary {
  const factory _AttendanceSummary(
      {final int totalDaysLogged,
      final double attendanceRate,
      final Amounts counts}) = _$AttendanceSummaryImpl;

  factory _AttendanceSummary.fromJson(Map<String, dynamic> json) =
      _$AttendanceSummaryImpl.fromJson;

  @override
  int get totalDaysLogged;
  @override
  double get attendanceRate;
  @override
  Amounts get counts;

  /// Create a copy of AttendanceSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceSummaryImplCopyWith<_$AttendanceSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Amounts _$AmountsFromJson(Map<String, dynamic> json) {
  return _Amounts.fromJson(json);
}

/// @nodoc
mixin _$Amounts {
  int get present => throw _privateConstructorUsedError;
  int get absent => throw _privateConstructorUsedError;
  int get late => throw _privateConstructorUsedError;
  int get excused => throw _privateConstructorUsedError;

  /// Serializes this Amounts to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Amounts
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AmountsCopyWith<Amounts> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmountsCopyWith<$Res> {
  factory $AmountsCopyWith(Amounts value, $Res Function(Amounts) then) =
      _$AmountsCopyWithImpl<$Res, Amounts>;
  @useResult
  $Res call({int present, int absent, int late, int excused});
}

/// @nodoc
class _$AmountsCopyWithImpl<$Res, $Val extends Amounts>
    implements $AmountsCopyWith<$Res> {
  _$AmountsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Amounts
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? present = null,
    Object? absent = null,
    Object? late = null,
    Object? excused = null,
  }) {
    return _then(_value.copyWith(
      present: null == present
          ? _value.present
          : present // ignore: cast_nullable_to_non_nullable
              as int,
      absent: null == absent
          ? _value.absent
          : absent // ignore: cast_nullable_to_non_nullable
              as int,
      late: null == late
          ? _value.late
          : late // ignore: cast_nullable_to_non_nullable
              as int,
      excused: null == excused
          ? _value.excused
          : excused // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AmountsImplCopyWith<$Res> implements $AmountsCopyWith<$Res> {
  factory _$$AmountsImplCopyWith(
          _$AmountsImpl value, $Res Function(_$AmountsImpl) then) =
      __$$AmountsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int present, int absent, int late, int excused});
}

/// @nodoc
class __$$AmountsImplCopyWithImpl<$Res>
    extends _$AmountsCopyWithImpl<$Res, _$AmountsImpl>
    implements _$$AmountsImplCopyWith<$Res> {
  __$$AmountsImplCopyWithImpl(
      _$AmountsImpl _value, $Res Function(_$AmountsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Amounts
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? present = null,
    Object? absent = null,
    Object? late = null,
    Object? excused = null,
  }) {
    return _then(_$AmountsImpl(
      present: null == present
          ? _value.present
          : present // ignore: cast_nullable_to_non_nullable
              as int,
      absent: null == absent
          ? _value.absent
          : absent // ignore: cast_nullable_to_non_nullable
              as int,
      late: null == late
          ? _value.late
          : late // ignore: cast_nullable_to_non_nullable
              as int,
      excused: null == excused
          ? _value.excused
          : excused // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AmountsImpl implements _Amounts {
  const _$AmountsImpl(
      {this.present = 0, this.absent = 0, this.late = 0, this.excused = 0});

  factory _$AmountsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AmountsImplFromJson(json);

  @override
  @JsonKey()
  final int present;
  @override
  @JsonKey()
  final int absent;
  @override
  @JsonKey()
  final int late;
  @override
  @JsonKey()
  final int excused;

  @override
  String toString() {
    return 'Amounts(present: $present, absent: $absent, late: $late, excused: $excused)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmountsImpl &&
            (identical(other.present, present) || other.present == present) &&
            (identical(other.absent, absent) || other.absent == absent) &&
            (identical(other.late, late) || other.late == late) &&
            (identical(other.excused, excused) || other.excused == excused));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, present, absent, late, excused);

  /// Create a copy of Amounts
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AmountsImplCopyWith<_$AmountsImpl> get copyWith =>
      __$$AmountsImplCopyWithImpl<_$AmountsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AmountsImplToJson(
      this,
    );
  }
}

abstract class _Amounts implements Amounts {
  const factory _Amounts(
      {final int present,
      final int absent,
      final int late,
      final int excused}) = _$AmountsImpl;

  factory _Amounts.fromJson(Map<String, dynamic> json) = _$AmountsImpl.fromJson;

  @override
  int get present;
  @override
  int get absent;
  @override
  int get late;
  @override
  int get excused;

  /// Create a copy of Amounts
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AmountsImplCopyWith<_$AmountsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
