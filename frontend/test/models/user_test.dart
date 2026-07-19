import 'package:flutter_test/flutter_test.dart';
import 'package:madrasapulse_frontend/models/user.dart';

void main() {
  group('AppUser', () {
    final json = {
      'id': 'user1',
      'madrasaId': 'mad1',
      'username': 'admin',
      'role': 'admin',
      'linkedEntityId': 'entity1',
      'isActive': true,
      'accessToken': 'token123',
      'refreshToken': 'refresh456',
    };

    test('fromJson creates AppUser correctly', () {
      final user = AppUser.fromJson(json);
      expect(user.id, 'user1');
      expect(user.madrasaId, 'mad1');
      expect(user.username, 'admin');
      expect(user.role, 'admin');
      expect(user.linkedEntityId, 'entity1');
      expect(user.isActive, true);
      expect(user.accessToken, 'token123');
      expect(user.refreshToken, 'refresh456');
    });

    test('toJson serializes correctly', () {
      final user = AppUser.fromJson(json);
      final serialized = user.toJson();
      expect(serialized['id'], 'user1');
      expect(serialized['madrasaId'], 'mad1');
      expect(serialized['username'], 'admin');
      expect(serialized['role'], 'admin');
      expect(serialized['isActive'], true);
    });

    test('fromJson/toJson round-trip produces same data', () {
      final user = AppUser.fromJson(json);
      final serialized = user.toJson();
      final deserialized = AppUser.fromJson(serialized);
      expect(deserialized.id, user.id);
      expect(deserialized.username, user.username);
      expect(deserialized.role, user.role);
    });

    test('copyWith creates modified copy', () {
      final user = AppUser.fromJson(json);
      final modified = user.copyWith(username: 'editor');
      expect(modified.username, 'editor');
      expect(modified.id, user.id);
      expect(modified.role, user.role);
    });

    test('fromJson handles missing id via _readId fallback', () {
      final jsonWithUnderscoreId = {
        '_id': 'user2',
        'madrasaId': 'mad2',
        'username': 'teacher1',
        'role': 'teacher',
      };
      final user = AppUser.fromJson(jsonWithUnderscoreId);
      expect(user.id, 'user2');
    });
  });
}
