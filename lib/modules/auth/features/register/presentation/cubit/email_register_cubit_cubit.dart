import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:time_tracking/core/constants.dart';
import 'package:time_tracking/modules/auth/features/register/domain/usecase/register_use_case.dart';
import 'package:time_tracking/modules/auth/features/register/model/register_model.dart';

part 'email_register_cubit_state.dart';

class EmailRegisterCubit extends Cubit<EmailRegisterCubitState> {
  final RegisterUseCase _registerUseCase;
  EmailRegisterCubit(this._registerUseCase)
      : super(EmailRegisterCubitInitial());

  Future<void> registerUser({required RegisterModel data}) async {
    if (data.fullName.isEmpty) {
      emit(FullNameValidationState(errorMessage: 'Full Name cannot be empty'));
      return;
    } else if (data.password.isEmpty) {
      emit(PasswordValidationState(errorMessage: 'Password cannot be empty'));
      return;
    } else {
      final bool emailValid =
          RegExp(AppConstant.emailRegex).hasMatch(data.email);
      if (!emailValid) {
        emit(EmailValidationState(errorMessage: 'Email is invalid'));
        return;
      }
    }

    emit(EmailRegisterLoading());
    final response = await _registerUseCase.execute(
      params: data,
    );
    response.fold(
      (error) => emit(RegisterErrorState(error)),
      (data) => emit(RegisterSuccessfulState()),
    );
  }
}
