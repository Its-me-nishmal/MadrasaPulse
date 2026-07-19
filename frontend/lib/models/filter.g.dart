// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FilterStateImpl _$$FilterStateImplFromJson(Map<String, dynamic> json) =>
    _$FilterStateImpl(
      search: json['search'] as String?,
      classIds: (json['classIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      status: json['status'] as String? ?? '',
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 20,
    );

Map<String, dynamic> _$$FilterStateImplToJson(_$FilterStateImpl instance) =>
    <String, dynamic>{
      'search': instance.search,
      'classIds': instance.classIds,
      'status': instance.status,
      'page': instance.page,
      'limit': instance.limit,
    };
