import 'package:equatable/equatable.dart';

/// ViewModel Layer Failures
/// 
/// Failures represent errors that the ViewModel sends to the UI.
/// They contain user-friendly, localized error messages.
/// Extends Equatable to support easy state comparisons in Bloc/Cubit/ViewModel.

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Represents an error from an external API (Weather, Gemini)
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Service is temporarily unavailable. Please try again later.']);
}

/// Represents an error from Firebase Realtime Database or IoT device state
class DatabaseFailure extends Failure {
  const DatabaseFailure([super.message = 'Unable to access plant data at the moment.']);
}

/// Represents an error in User Authentication (Login/Register)
class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed. Please check your credentials.']);
}

/// Represents an error in Local Storage (Shared Preferences)
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Could not retrieve your local settings.']);
}

/// Represents a Network connection error
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'It looks like you are offline. Please check your internet.']);
}

/// Represents an error in IoT device communication (Pumps, Hardware sensors)
class DeviceFailure extends Failure {
  const DeviceFailure([super.message = 'Failed to communicate with your GrowIQ hardware.']);
}
