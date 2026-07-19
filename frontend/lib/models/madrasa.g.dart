// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'madrasa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MadrasaImpl _$$MadrasaImplFromJson(Map<String, dynamic> json) =>
    _$MadrasaImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      domain: json['domain'] as String?,
      contactInfo: json['contactInfo'] == null
          ? null
          : PhoneInfo.fromJson(json['contactInfo'] as Map<String, dynamic>),
      enabledModules: (json['enabledModules'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      plan: json['plan'] as String? ?? 'Basic',
      subscriptionExpiresAt: json['subscriptionExpiresAt'] as String?,
    );

Map<String, dynamic> _$$MadrasaImplToJson(_$MadrasaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'domain': instance.domain,
      'contactInfo': instance.contactInfo,
      'enabledModules': instance.enabledModules,
      'plan': instance.plan,
      'subscriptionExpiresAt': instance.subscriptionExpiresAt,
    };

_$PhoneInfoImpl _$$PhoneInfoImplFromJson(Map<String, dynamic> json) =>
    _$PhoneInfoImpl(
      phone: json['phone'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$PhoneInfoImplToJson(_$PhoneInfoImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'email': instance.email,
    };
