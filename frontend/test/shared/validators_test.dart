import 'package:flutter_test/flutter_test.dart';
import 'package:madrasapulse_frontend/shared/utils/validators.dart';

void main() {
  group('Validators', () {
    test('required returns error for empty string', () {
      expect(Validators.required(''), isNotNull);
      expect(Validators.required(null), isNotNull);
    });

    test('required returns null for non-empty string', () {
      expect(Validators.required('hello'), isNull);
    });

    test('email returns error for invalid email', () {
      expect(Validators.email('notanemail'), isNotNull);
    });

    test('email returns null for valid email', () {
      expect(Validators.email('test@example.com'), isNull);
    });

    test('phone returns error for short number', () {
      expect(Validators.phone('123'), isNotNull);
    });

    test('phone returns null for valid number', () {
      expect(Validators.phone('1234567890'), isNull);
    });
  });
}
