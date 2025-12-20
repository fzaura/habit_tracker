
import 'package:habit_tracker/data/Auth/DataModels/userModelOnRegister.dart';

abstract class AuthRemoteDataSourceInterFace {
  
  Future<UserModelOnRegister> register({
    required String username,
    required String email,
    required String password,
        required String confirmPassword,

  });
}