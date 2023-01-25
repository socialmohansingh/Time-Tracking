import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/modules/auth/features/login/domain/repository/login_repository.dart';
import 'package:time_tracking/modules/auth/features/login/model/login_model.dart';

class LoginUseCase {
  final LoginRepository _loginRepository;

  LoginUseCase(this._loginRepository);

  Future<Result<String, User>> call({required LoginModel loginData}) async {
    return _loginRepository.login(loginData: loginData);
  }
}
