import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/modules/auth/features/register/domain/repository/register_repository.dart';
import 'package:time_tracking/modules/auth/features/register/model/register_model.dart';

class RegisterUseCase extends BaseUseCase<Result<String, User>,RegisterModel> {
  final RegisterRepository _registerRepository;

  RegisterUseCase(this._registerRepository);
  
  @override
  Future<Result<String, User>> execute({RegisterModel? params}) {
   return _registerRepository.register(registerData: params!);
  }
  
 

}
