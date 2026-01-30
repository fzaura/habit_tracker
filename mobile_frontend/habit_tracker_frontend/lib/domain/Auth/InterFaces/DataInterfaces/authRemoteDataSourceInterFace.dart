
import 'package:dio/dio.dart';
import 'package:habit_tracker/data/Auth/DataModels/userModelOnRegister.dart';
import 'package:habit_tracker/data/Auth/DataModels/TokenModel.dart';

abstract interface class AuthRemoteDataSourceInterFace {
  const AuthRemoteDataSourceInterFace({required this.client});
  final Dio client;
  
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


 Future<Response<dynamic>> retryRequest(RequestOptions requestOptions, String newAccessToken );


}