import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/modules/auth/features/register/data/register_remote_data_source.dart';
import 'package:time_tracking/modules/auth/features/register/domain/repository/register_repository.dart';
import 'package:time_tracking/modules/auth/features/register/model/register_model.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final RegisterRemoteDataSource _loginRemoteDataSource;

  RegisterRepositoryImpl(this._loginRemoteDataSource);

  @override
  Future<Result<String, User>> register({required RegisterModel registerData}) {
    return _loginRemoteDataSource.register(registerData: registerData);
  }
}
