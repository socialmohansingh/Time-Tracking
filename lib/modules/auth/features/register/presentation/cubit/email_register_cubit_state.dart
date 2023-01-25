part of 'email_register_cubit_cubit.dart';

@immutable
abstract class EmailRegisterCubitState {}

class EmailRegisterCubitInitial extends EmailRegisterCubitState {}

class EmailRegisterLoading extends EmailRegisterCubitState {}

class RegisterSuccessfulState extends EmailRegisterCubitState {}

class RegisterErrorState extends EmailRegisterCubitState {
  final String error;

  RegisterErrorState(this.error);
}

class EmailValidationState extends EmailRegisterCubitState {
  final String errorMessage;

  EmailValidationState({required this.errorMessage});
}

class PasswordValidationState extends EmailRegisterCubitState {
  final String errorMessage;

  PasswordValidationState({required this.errorMessage});
}

class FullNameValidationState extends EmailRegisterCubitState {
  final String errorMessage;

  FullNameValidationState({required this.errorMessage});
}
