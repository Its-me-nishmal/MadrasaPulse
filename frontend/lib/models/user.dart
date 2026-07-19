import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String madrasaId,
    required String username,
    required String role,
    String? linkedEntityId,
    @Default(false) bool isActive,
    String? accessToken,
    String? refreshToken,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null && json['_id'] != null) {
      json = {...json, 'id': json['_id']};
    }
    return _$AppUserFromJson(json);
  }
}
