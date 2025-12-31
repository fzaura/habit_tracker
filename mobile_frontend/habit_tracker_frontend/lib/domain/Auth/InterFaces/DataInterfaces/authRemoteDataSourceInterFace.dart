
import 'package:habit_tracker/data/Auth/DataModels/userModelOnRegister.dart';
import 'package:habit_tracker/data/Habits/DataModels/TokenModel.dart';

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

    Future<TokenModel> refreshTokens(String oldRefreshToken);

}