part of 'email_login_cubit.dart';

abstract class EmailLoginState {}

class EmailLoginInitial extends EmailLoginState {}

class EmailLoginData extends EmailLoginState {
  final User user;

  EmailLoginData(this.user);
}

class EmailLoginError extends EmailLoginState {
  final String error;

  EmailLoginError(this.error);
}

class EmailValidationError extends EmailLoginState {
  final String email;

  EmailValidationError(this.email);
}

class PasswordValidationError extends EmailLoginState {}

class EmailLoginLoading extends EmailLoginState {}
