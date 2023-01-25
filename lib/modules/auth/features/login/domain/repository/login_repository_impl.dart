import 'package:flutter_core/src/utils/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracking/modules/auth/features/login/data/login_remote_data_source.dart';
import 'package:time_tracking/modules/auth/features/login/domain/repository/login_repository.dart';
import 'package:time_tracking/modules/auth/features/login/model/login_model.dart';

class LoginRespositoryImpl extends LoginRepository {
  final LoginRemoteDataSource _loginRemoteDataSource;

  LoginRespositoryImpl(this._loginRemoteDataSource);

  @override
  Future<Result<String, User>> login({required LoginModel loginData}) {
    return _loginRemoteDataSource.login(loginData: loginData);
  }
}
