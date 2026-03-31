import 'failures.dart';

/// Result Wrapper to handle Success or Failure in a functional way.
/// Using Dart 3 Sealed classes features for state safety across the app.
sealed class AppResult<T> {
  const AppResult();

  /// Returns true if the result is a [Success]
  bool get isSuccess => this is Success<T>;

  /// Returns true if the result is a [FailureResult]
  bool get isFailure => this is FailureResult<T>;

  /// Returns the data if the result is [Success], otherwise null
  T? get dataOrNull => this is Success<T> ? (this as Success<T>).data : null;

  /// Returns the failure if the result is [FailureResult], otherwise null
  Failure? get failureOrNull => this is FailureResult<T> ? (this as FailureResult<T>).failure : null;
}

/// Success State: Contains the data of type [T]
class Success<T> extends AppResult<T> {
  final T data;
  const Success(this.data);
}

/// Failure State: Contains a [Failure] object with error details
class FailureResult<T> extends AppResult<T> {
  final Failure failure;
  const FailureResult(this.failure);
}
