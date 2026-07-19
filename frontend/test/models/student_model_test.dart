import 'package:flutter_test/flutter_test.dart';
import 'package:madrasapulse_frontend/models/student.dart';

void main() {
  group('Student Model', () {
    test('fromJson parses correctly', () {
      final json = {
        '_id': 'abc123',
        'madrasaId': 'mad1',
        'admissionNo': 'ADM001',
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
        'isDeleted': false,
      };

      final student = Student.fromJson(json);
      expect(student.id, 'abc123');
      expect(student.firstName, 'John');
      expect(student.lastName, 'Doe');
      expect(student.guardians.length, 1);
    });

    test('default values are correct', () {
      const student = Student(
        id: '1',
        madrasaId: 'm1',
        admissionNo: 'A1',
      );
      expect(student.isDeleted, false);
      expect(student.guardians, isEmpty);
    });
  });
}
