
import 'package:habit_tracker/data/Auth/DataModels/userModelOnRegister.dart';

abstract class AuthRemoteDataSourceInterFace {
  
  Future<UserModel> register({
    required String username,
    required String email,
    required String password,
        required String confirmPassword,

  });

   Future<UserModel> login({
    required String email,
    required String password,
  });
}