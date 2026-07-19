import 'package:flutter_test/flutter_test.dart';
import 'package:madrasapulse_frontend/models/failure.dart';

void main() {
  group('Failure Model', () {
    test('parse returns UnauthorizedFailure for UNAUTHORIZED code', () {
      final f = Failure.parse({'code': 'UNAUTHORIZED', 'message': 'Bad token'});
      expect(f, isA<UnauthorizedFailure>());
    });

    test('parse returns default UnexpectedFailure for unknown code', () {
      final f = Failure.parse({'message': 'Something broke'});
      expect(f, isA<UnexpectedFailure>());
    });
  });
}
