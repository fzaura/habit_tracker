import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:habit_tracker/core/Errors/accessDeniedFailure.dart';
import 'package:habit_tracker/data/Auth/DataModels/userModelOnRegister.dart';
import 'package:habit_tracker/data/Auth/DataSource/AuthRemoteDataSource.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/DataInterfaces/AuthRepo.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/TokenStorage/tokenStorage.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

class AuthRepo extends AuthRepositoryInterFace {
  final AuthRemoteDataSource remoteDataSource;
  final TokenStorage tokenStorage;
  //local data source
  AuthRepo({required this.remoteDataSource, required this.tokenStorage});
  @override
  Future<Either<ErrorInterface, UserModelOnRegister>> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await remoteDataSource.register(
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      //2- Before Saving Save the New Tokens to Local Storage of teh phone.
      // 2. SAVE IT TO THE VAULT (This is why you need it!)
      await tokenStorage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      return Right(response);
    } on DioException catch (e) {
      print(e.error);
      return Left(
        AccessDeniedfailure(
          errorMessage: 'The Error is  ${e.message}',
          statusCode: 'Status Code is : ${e.response?.statusCode} ',
        ),
      );
    }
  }
}
