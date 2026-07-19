import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:madrasapulse_frontend/models/student.dart';

void main() {
  group('Student', () {
    final json = {
      'id': '123',
      'madrasaId': 'mad1',
      'admissionNo': 'A001',
      'rollNo': 'R1',
      'firstName': 'John',
      'lastName': 'Doe',
      'guardians': [
        {
          'name': 'Jane Doe',
          'relationship': 'Mother',
          'phone': '1234567890',
          'isPrimary': true,
        },
      ],
      'dateOfBirth': '2010-01-01',
      'classId': 'class1',
      'isDeleted': false,
      'formattedName': 'John Doe',
    };

    test('fromJson creates Student correctly', () {
      final student = Student.fromJson(json);
      expect(student.id, '123');
      expect(student.madrasaId, 'mad1');
      expect(student.admissionNo, 'A001');
      expect(student.rollNo, 'R1');
      expect(student.firstName, 'John');
      expect(student.lastName, 'Doe');
      expect(student.guardians.length, 1);
      expect(student.guardians.first.name, 'Jane Doe');
      expect(student.dateOfBirth, '2010-01-01');
      expect(student.classId, 'class1');
      expect(student.isDeleted, false);
      expect(student.formattedName, 'John Doe');
    });

    test('toJson serializes correctly', () {
      final student = Student.fromJson(json);
      final serialized = student.toJson();
      expect(serialized['id'], '123');
      expect(serialized['madrasaId'], 'mad1');
      expect(serialized['admissionNo'], 'A001');
      expect(serialized['firstName'], 'John');
      expect(serialized['lastName'], 'Doe');
      expect((serialized['guardians'] as List).length, 1);
    });

    test('fromJson/toJson round-trip produces same data', () {
      final student = Student.fromJson(json);
      final encoded = jsonEncode(student.toJson());
      final decoded = jsonDecode(encoded);
      final deserialized = Student.fromJson(decoded);
      expect(deserialized.id, student.id);
      expect(deserialized.madrasaId, student.madrasaId);
      expect(deserialized.admissionNo, student.admissionNo);
    });

    test('copyWith creates modified copy', () {
      final student = Student.fromJson(json);
      final modified = student.copyWith(firstName: 'Jane');
      expect(modified.firstName, 'Jane');
      expect(modified.id, student.id);
      expect(modified.lastName, student.lastName);
    });

    test('fromJson handles missing id via _readId fallback', () {
      final jsonWithUnderscoreId = {
        '_id': '456',
        'madrasaId': 'mad1',
        'admissionNo': 'A002',
      };
      final student = Student.fromJson(jsonWithUnderscoreId);
      expect(student.id, '456');
    });
  });

  group('Guardian', () {
    test('fromJson creates Guardian correctly', () {
      final json = {
        'name': 'Parent',
        'relationship': 'Father',
        'phone': '9876543210',
        'isPrimary': true,
      };
      final guardian = Guardian.fromJson(json);
      expect(guardian.name, 'Parent');
      expect(guardian.relationship, 'Father');
      expect(guardian.phone, '9876543210');
      expect(guardian.isPrimary, true);
    });

    test('copyWith creates modified copy', () {
      const guardian = Guardian(
        name: 'Parent',
        relationship: 'Father',
        phone: '9876543210',
        isPrimary: true,
      );
      final modified = guardian.copyWith(isPrimary: false);
      expect(modified.isPrimary, false);
      expect(modified.name, 'Parent');
    });
  });
}
