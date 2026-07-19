import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

Object? _readId(Map map, String key) => map['id'] ?? map['_id'];

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    @JsonKey(readValue: _readId) required String id,
    required String madrasaId,
    required String username,
    required String role,
    String? linkedEntityId,
    @Default(false) bool isActive,
    String? accessToken,
    String? refreshToken,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
