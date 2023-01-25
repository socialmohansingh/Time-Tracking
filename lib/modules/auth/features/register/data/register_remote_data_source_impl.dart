import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/modules/auth/features/register/data/register_remote_data_source.dart';
import 'package:time_tracking/modules/auth/features/register/model/register_model.dart';

class RegisterRemoteDataSourceImpl extends RegisterRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance.collection('user');
  @override
  Future<Result<String, User>> register(
      {required RegisterModel registerData}) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: registerData.email,
        password: registerData.password,
      );
      if (user.user == null) {
        return Failure('Something Went Wrong');
      }

      await user.user?.updateDisplayName(registerData.fullName);
      await _firestore.doc().set({
        'name': registerData.fullName,
        'id': user.user?.uid,
        'email': user.user?.email,
      });

      return Success(user.user!);
    } on FirebaseAuthException catch (e) {
      String? errorMessage;
      if (e.code == 'email-already-in-use') {
        errorMessage = 'Provided image is already in use';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Password is weak,Please try different one';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Entered Email in invalid';
      }
      return Failure(errorMessage ?? 'Something Went Wrong');
    } catch (e) {
      return Failure('Something Went Wrong');
    }
  }
}
