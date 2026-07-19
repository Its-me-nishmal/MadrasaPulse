import 'package:freezed_annotation/freezed_annotation.dart';

part 'madrasa.freezed.dart';
part 'madrasa.g.dart';

@freezed
class Madrasa with _$Madrasa {
  const factory Madrasa({
    required String id,
    required String name,
    String? domain,
    PhoneInfo? contactInfo,
    @Default([]) List<String> enabledModules,
    @Default('Basic') String plan,
    String? subscriptionExpiresAt,
  }) = _Madrasa;

  factory Madrasa.fromJson(Map<String, dynamic> json) => _$MadrasaFromJson(json);
}

@freezed
class PhoneInfo with _$PhoneInfo {
  const factory PhoneInfo({
    String? phone,
    String? email,
  }) = _PhoneInfo;

  factory PhoneInfo.fromJson(Map<String, dynamic> json) => _$PhoneInfoFromJson(json);
}
