//all states related to Auth Cubit

sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class SignupLoadingState extends AuthState {}
final class SignupSuccessState extends AuthState {}
final class SignupFailureState extends AuthState {
  final String errMessage;
  SignupFailureState(this.errMessage);
}
final class PasswordVisibilityChangedState extends AuthState {}
final class ConfirmPasswordVisibilityChangedState extends AuthState {}


final class SignInLoadingState extends AuthState {}
final class SignInSuccessState extends AuthState {}
final class SignInFailureState extends AuthState {
  final String errMessage;
  SignInFailureState(this.errMessage);
}

