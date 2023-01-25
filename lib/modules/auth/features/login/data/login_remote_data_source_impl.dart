import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/modules/auth/features/login/data/login_remote_data_source.dart';
import 'package:time_tracking/modules/auth/features/login/model/login_model.dart';

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Future<Result<String, User>> login({required LoginModel loginData}) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: loginData.email, password: loginData.password);
      if (user.user == null) {
        return Failure('Something Went Wrong');
      }
      return Success(user.user!);
    } on FirebaseAuthException catch (e) {
      print(e);
      String? errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'User with given Email is not registered';
      } else if (e.code == 'user-disabled') {
        errorMessage = 'User is disabled';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Entered Password is Wrong';
      }
      return Failure(errorMessage ?? 'Something went wrong');
    } catch (e) {
      return Failure('Something Went Wrong');
    }
  }
}
