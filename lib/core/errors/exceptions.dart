abstract class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, [this.code]);

  @override
  String toString() => 'AppException: $message (code: $code)';
}

/// Thrown during External API calls (Weather API, Gemini AI API)
class ServerException extends AppException {
  const ServerException([super.message = 'Server process failed', super.code]);
}

/// Thrown during Firebase Realtime Database operations
class DatabaseException extends AppException {
  const DatabaseException([super.message = 'Database operation failed', super.code]);
}

/// Thrown during Firebase Authentication processes
class AuthException extends AppException {
  const AuthException([super.message = 'Authentication failed', super.code]);
}

/// Thrown during Local Storage operations (SharedPreferences)
class CacheException extends AppException {
  const CacheException([super.message = 'Cache operation failed', super.code]);
}

/// Thrown when there is no internet connectivity
class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection', super.code]);
}

/// Thrown when communication with IoT hardware (pumps, sensors) fails
class DeviceException extends AppException {
  const DeviceException([super.message = 'IoT device communication failed', super.code]);
}
