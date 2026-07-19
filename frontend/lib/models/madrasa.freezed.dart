// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'madrasa.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Madrasa _$MadrasaFromJson(Map<String, dynamic> json) {
  return _Madrasa.fromJson(json);
}

/// @nodoc
mixin _$Madrasa {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get domain => throw _privateConstructorUsedError;
  PhoneInfo? get contactInfo => throw _privateConstructorUsedError;
  List<String> get enabledModules => throw _privateConstructorUsedError;
  String get plan => throw _privateConstructorUsedError;
  String? get subscriptionExpiresAt => throw _privateConstructorUsedError;

  /// Serializes this Madrasa to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Madrasa
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MadrasaCopyWith<Madrasa> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MadrasaCopyWith<$Res> {
  factory $MadrasaCopyWith(Madrasa value, $Res Function(Madrasa) then) =
      _$MadrasaCopyWithImpl<$Res, Madrasa>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? domain,
      PhoneInfo? contactInfo,
      List<String> enabledModules,
      String plan,
      String? subscriptionExpiresAt});

  $PhoneInfoCopyWith<$Res>? get contactInfo;
}

/// @nodoc
class _$MadrasaCopyWithImpl<$Res, $Val extends Madrasa>
    implements $MadrasaCopyWith<$Res> {
  _$MadrasaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Madrasa
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? domain = freezed,
    Object? contactInfo = freezed,
    Object? enabledModules = null,
    Object? plan = null,
    Object? subscriptionExpiresAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      domain: freezed == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String?,
      contactInfo: freezed == contactInfo
          ? _value.contactInfo
          : contactInfo // ignore: cast_nullable_to_non_nullable
              as PhoneInfo?,
      enabledModules: null == enabledModules
          ? _value.enabledModules
          : enabledModules // ignore: cast_nullable_to_non_nullable
              as List<String>,
      plan: null == plan
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as String,
      subscriptionExpiresAt: freezed == subscriptionExpiresAt
          ? _value.subscriptionExpiresAt
          : subscriptionExpiresAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of Madrasa
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PhoneInfoCopyWith<$Res>? get contactInfo {
    if (_value.contactInfo == null) {
      return null;
    }

    return $PhoneInfoCopyWith<$Res>(_value.contactInfo!, (value) {
      return _then(_value.copyWith(contactInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MadrasaImplCopyWith<$Res> implements $MadrasaCopyWith<$Res> {
  factory _$$MadrasaImplCopyWith(
          _$MadrasaImpl value, $Res Function(_$MadrasaImpl) then) =
      __$$MadrasaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? domain,
      PhoneInfo? contactInfo,
      List<String> enabledModules,
      String plan,
      String? subscriptionExpiresAt});

  @override
  $PhoneInfoCopyWith<$Res>? get contactInfo;
}

/// @nodoc
class __$$MadrasaImplCopyWithImpl<$Res>
    extends _$MadrasaCopyWithImpl<$Res, _$MadrasaImpl>
    implements _$$MadrasaImplCopyWith<$Res> {
  __$$MadrasaImplCopyWithImpl(
      _$MadrasaImpl _value, $Res Function(_$MadrasaImpl) _then)
      : super(_value, _then);

  /// Create a copy of Madrasa
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? domain = freezed,
    Object? contactInfo = freezed,
    Object? enabledModules = null,
    Object? plan = null,
    Object? subscriptionExpiresAt = freezed,
  }) {
    return _then(_$MadrasaImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      domain: freezed == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String?,
      contactInfo: freezed == contactInfo
          ? _value.contactInfo
          : contactInfo // ignore: cast_nullable_to_non_nullable
              as PhoneInfo?,
      enabledModules: null == enabledModules
          ? _value._enabledModules
          : enabledModules // ignore: cast_nullable_to_non_nullable
              as List<String>,
      plan: null == plan
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as String,
      subscriptionExpiresAt: freezed == subscriptionExpiresAt
          ? _value.subscriptionExpiresAt
          : subscriptionExpiresAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MadrasaImpl implements _Madrasa {
  const _$MadrasaImpl(
      {required this.id,
      required this.name,
      this.domain,
      this.contactInfo,
      final List<String> enabledModules = const [],
      this.plan = 'Basic',
      this.subscriptionExpiresAt})
      : _enabledModules = enabledModules;

  factory _$MadrasaImpl.fromJson(Map<String, dynamic> json) =>
      _$$MadrasaImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? domain;
  @override
  final PhoneInfo? contactInfo;
  final List<String> _enabledModules;
  @override
  @JsonKey()
  List<String> get enabledModules {
    if (_enabledModules is EqualUnmodifiableListView) return _enabledModules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_enabledModules);
  }

  @override
  @JsonKey()
  final String plan;
  @override
  final String? subscriptionExpiresAt;

  @override
  String toString() {
    return 'Madrasa(id: $id, name: $name, domain: $domain, contactInfo: $contactInfo, enabledModules: $enabledModules, plan: $plan, subscriptionExpiresAt: $subscriptionExpiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MadrasaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.domain, domain) || other.domain == domain) &&
            (identical(other.contactInfo, contactInfo) ||
                other.contactInfo == contactInfo) &&
            const DeepCollectionEquality()
                .equals(other._enabledModules, _enabledModules) &&
            (identical(other.plan, plan) || other.plan == plan) &&
            (identical(other.subscriptionExpiresAt, subscriptionExpiresAt) ||
                other.subscriptionExpiresAt == subscriptionExpiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      domain,
      contactInfo,
      const DeepCollectionEquality().hash(_enabledModules),
      plan,
      subscriptionExpiresAt);

  /// Create a copy of Madrasa
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MadrasaImplCopyWith<_$MadrasaImpl> get copyWith =>
      __$$MadrasaImplCopyWithImpl<_$MadrasaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MadrasaImplToJson(
      this,
    );
  }
}

abstract class _Madrasa implements Madrasa {
  const factory _Madrasa(
      {required final String id,
      required final String name,
      final String? domain,
      final PhoneInfo? contactInfo,
      final List<String> enabledModules,
      final String plan,
      final String? subscriptionExpiresAt}) = _$MadrasaImpl;

  factory _Madrasa.fromJson(Map<String, dynamic> json) = _$MadrasaImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get domain;
  @override
  PhoneInfo? get contactInfo;
  @override
  List<String> get enabledModules;
  @override
  String get plan;
  @override
  String? get subscriptionExpiresAt;

  /// Create a copy of Madrasa
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MadrasaImplCopyWith<_$MadrasaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PhoneInfo _$PhoneInfoFromJson(Map<String, dynamic> json) {
  return _PhoneInfo.fromJson(json);
}

/// @nodoc
mixin _$PhoneInfo {
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;

  /// Serializes this PhoneInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PhoneInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhoneInfoCopyWith<PhoneInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhoneInfoCopyWith<$Res> {
  factory $PhoneInfoCopyWith(PhoneInfo value, $Res Function(PhoneInfo) then) =
      _$PhoneInfoCopyWithImpl<$Res, PhoneInfo>;
  @useResult
  $Res call({String? phone, String? email});
}

/// @nodoc
class _$PhoneInfoCopyWithImpl<$Res, $Val extends PhoneInfo>
    implements $PhoneInfoCopyWith<$Res> {
  _$PhoneInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhoneInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = freezed,
    Object? email = freezed,
  }) {
    return _then(_value.copyWith(
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhoneInfoImplCopyWith<$Res>
    implements $PhoneInfoCopyWith<$Res> {
  factory _$$PhoneInfoImplCopyWith(
          _$PhoneInfoImpl value, $Res Function(_$PhoneInfoImpl) then) =
      __$$PhoneInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? phone, String? email});
}

/// @nodoc
class __$$PhoneInfoImplCopyWithImpl<$Res>
    extends _$PhoneInfoCopyWithImpl<$Res, _$PhoneInfoImpl>
    implements _$$PhoneInfoImplCopyWith<$Res> {
  __$$PhoneInfoImplCopyWithImpl(
      _$PhoneInfoImpl _value, $Res Function(_$PhoneInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of PhoneInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = freezed,
    Object? email = freezed,
  }) {
    return _then(_$PhoneInfoImpl(
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PhoneInfoImpl implements _PhoneInfo {
  const _$PhoneInfoImpl({this.phone, this.email});

  factory _$PhoneInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhoneInfoImplFromJson(json);

  @override
  final String? phone;
  @override
  final String? email;

  @override
  String toString() {
    return 'PhoneInfo(phone: $phone, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneInfoImpl &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phone, email);

  /// Create a copy of PhoneInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneInfoImplCopyWith<_$PhoneInfoImpl> get copyWith =>
      __$$PhoneInfoImplCopyWithImpl<_$PhoneInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhoneInfoImplToJson(
      this,
    );
  }
}

abstract class _PhoneInfo implements PhoneInfo {
  const factory _PhoneInfo({final String? phone, final String? email}) =
      _$PhoneInfoImpl;

  factory _PhoneInfo.fromJson(Map<String, dynamic> json) =
      _$PhoneInfoImpl.fromJson;

  @override
  String? get phone;
  @override
  String? get email;

  /// Create a copy of PhoneInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhoneInfoImplCopyWith<_$PhoneInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
