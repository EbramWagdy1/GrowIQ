import 'exceptions.dart';
import 'failures.dart';

/// ErrorMapper Helper
///
/// Responsible for mapping technical [AppException]s (Data layer)
/// to user-friendly [Failure]s (Presentation layer).
/// This prevents technical details (like API status codes) from leaking into the UI.

class ErrorMapper {
  /// Map [AppException] to its corresponding [Failure]
  static Failure mapToFailure(AppException exception) {
    if (exception is ServerException) {
      return ServerFailure(exception.message);
    } else if (exception is DatabaseException) {
      return DatabaseFailure(exception.message);
    } else if (exception is AuthException) {
      return AuthFailure(exception.message);
    } else if (exception is NetworkException) {
      return NetworkFailure(exception.message);
    } else if (exception is DeviceException) {
      return DeviceFailure(exception.message);
    } else if (exception is CacheException) {
      return CacheFailure(exception.message);
    } else {
      return const ServerFailure('An unexpected error occurred. Please try again.');
    }
  }

  /// Map Firebase Error codes to specific Failures
  static Failure mapFirebaseErrorCode(String code) {
    switch (code) {
      case 'user-not-found':
        return const AuthFailure('No user found with this email.');
      case 'wrong-password':
        return const AuthFailure('Incorrect password.');
      case 'network-request-failed':
        return const NetworkFailure();
      default:
        return AuthFailure('Authentication error: $code');
    }
  }
}
