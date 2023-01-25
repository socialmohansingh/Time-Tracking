import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/modules/auth/features/register/model/register_model.dart';

abstract class RegisterRemoteDataSource {
  Future<Result<String, User>> register({required RegisterModel registerData});
}
