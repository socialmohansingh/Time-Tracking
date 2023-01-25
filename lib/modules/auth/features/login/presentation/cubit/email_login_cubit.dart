import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/core/constants.dart';
import 'package:time_tracking/modules/auth/features/login/domain/usecase/login_use_case.dart';
import 'package:time_tracking/modules/auth/features/login/model/login_model.dart';

part 'email_login_state.dart';

class EmailLoginCubit extends Cubit<EmailLoginState> {
  final LoginUseCase _loginUseCase;
  EmailLoginCubit(this._loginUseCase) : super(EmailLoginInitial());

  Future<void> performLogin({required LoginModel loginData}) async {
    final bool emailValid =
        RegExp(AppConstant.emailRegex).hasMatch(loginData.email);

    if (!emailValid) {
      emit(EmailValidationError('Email is invalid'));
      return;
    } else if (loginData.password.isEmpty) {
      emit(PasswordValidationError());
      return;
    }

    emit(EmailLoginLoading());
    final response = await _loginUseCase.call(loginData: loginData);

    response.fold((error) => emit(EmailLoginError(error)),
        (data) => emit(EmailLoginData(data)));
  }
}
