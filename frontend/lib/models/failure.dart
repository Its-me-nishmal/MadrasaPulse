import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.server(String message) = ServerFailure;
  const factory Failure.network(String message) = NetworkFailure;
  const factory Failure.cache(String message) = CacheFailure;
  const factory Failure.unauthorized(String message) = UnauthorizedFailure;
  const factory Failure.validation(String message) = ValidationFailure;
  const factory Failure.unexpected(String message) = UnexpectedFailure;
  factory Failure.parse(Map<String, dynamic> error) {
    final msg = (error['message'] as String?) ?? 'An unknown error occurred';
    final code = (error['code'] as String?) ?? 'UNEXPECTED';

    switch (code.toUpperCase()) {
      case 'UNAUTHORIZED':
        return Failure.unauthorized(msg);
      case 'VALIDATION_FAILED':
        return Failure.validation(msg);
      default:
        return Failure.unexpected(msg);
    }
  }
}
