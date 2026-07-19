// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: _readId(json, 'id') as String,
      madrasaId: json['madrasaId'] as String,
      username: json['username'] as String,
      role: json['role'] as String,
      linkedEntityId: json['linkedEntityId'] as String?,
      isActive: json['isActive'] as bool? ?? false,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'madrasaId': instance.madrasaId,
      'username': instance.username,
      'role': instance.role,
      'linkedEntityId': instance.linkedEntityId,
      'isActive': instance.isActive,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
