import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/modules/auth/features/login/model/login_model.dart';

abstract class LoginRepository {

  Future<Result<String, User>> login({required LoginModel loginData});

}
