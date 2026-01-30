import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:habit_tracker/core/Errors/accessDeniedFailure.dart';
import 'package:habit_tracker/core/Errors/serverFailure.dart';
import 'package:habit_tracker/core/Errors/undefinedFailure.dart';
import 'package:habit_tracker/core/Service/secureTokenStorage.dart';
import 'package:habit_tracker/data/Auth/DataModels/userModelOnRegister.dart';
import 'package:habit_tracker/data/Auth/DataModels/TokenModel.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/DataInterfaces/AuthRepoistoryInterface.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/DataInterfaces/authRemoteDataSourceInterFace.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

class AuthRepo extends AuthRepositoryInterFace {
  final AuthRemoteDataSourceInterFace remoteDataSource;
  final SecureTokenStorage tokenStorage;
  //local data source
  AuthRepo({required this.remoteDataSource, required this.tokenStorage});

  @override
  Future<Either<ErrorInterface, TokenModel>> refreshTokens(
    String oldRefreshToken,
  ) async {
    try {
      final habits = await remoteDataSource.refreshTokens(oldRefreshToken);
      //1-Clear the Old Tokens.
      tokenStorage.clearTokens();
      //2-Save the New Tokens
      tokenStorage.saveTokens(
        accessToken: habits.accessToken,
        refreshToken: habits.refreshToken,
      );
      print(oldRefreshToken);
      return right(habits); //A Lits of Habit Models
    } on DioException catch (e) {
      // 3. FAILURE: Catch the technical exception and map it

      final statusCode = e.response?.statusCode;

      if (statusCode == 401 || statusCode == 403) {
        // 401/403: Indicates token/permission failure
        //Clear The STorage THE TOKENS ARE DEAD 
        tokenStorage.clearTokens();
        return left(
          AccessDeniedfailure(
            errorMessage:
                'Access Denied Token Permission Failed , ${e.message}',
          ),
        );
      } else if (statusCode != null && statusCode >= 500) {
        // 500-599: Server-side issue
        print('SERVER ERROR : $statusCode');
        print('SERVER ERROR message : ${e.error}');
        print('SERVER ERROR message it self : ${e.message}');

        return left(
          ServerFailure(errorMessage: e.message ?? 'Server error occurred'),
        );
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        print('SERVER ERROR : $statusCode');
        print('SERVER ERROR message : ${e.error}');
        print('SERVER ERROR message it self : ${e.message}');

        // Connection issues
        return left(
          ServerFailure(errorMessage: 'Connection failed. Check internet.'),
        );
      } else {
        return left(UnDefinedfailure(errorMessage: 'Allah A3lm'));
      }
    }
  }

  @override
  Future<Either<ErrorInterface, UserModel>> register({
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

  @override
  Future<Either<ErrorInterface, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.login(
        email: email,
        password: password,
      );
      tokenStorage.saveTokens(
        accessToken: userModel.accessToken,
        refreshToken: userModel.accessToken,
      );
      return Right(userModel);
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
// data/Auth/DataRepo/AuthRepo.dart
@override
Future<void> logout() async {
  // Logic: Logging out means the local credentials must be destroyed.
  await tokenStorage.clearTokens();
}

@override
Future<Either<ErrorInterface,Response<dynamic>>> retryRequest(RequestOptions requestOptions , String newAccessToken)
async {


try {
      final retryRequest = await remoteDataSource.retryRequest(requestOptions,newAccessToken);
    
      print(newAccessToken);
      return right(retryRequest); //A Lits of Habit Models
    } on DioException catch (e) {
      // 3. FAILURE: Catch the technical exception and map it

      final statusCode = e.response?.statusCode;

      if (statusCode == 401 || statusCode == 403) {
        // 401/403: Indicates token/permission failure
        //Clear The STorage THE TOKENS ARE DEAD 
        tokenStorage.clearTokens();
        return left(
          AccessDeniedfailure(
            errorMessage:
                'Access Denied Token Permission Failed , ${e.message}',
          ),
        );
      } else if (statusCode != null && statusCode >= 500) {
        // 500-599: Server-side issue
        print('SERVER ERROR : $statusCode');
        print('SERVER ERROR message : ${e.error}');
        print('SERVER ERROR message it self : ${e.message}');

        return left(
          ServerFailure(errorMessage: e.message ?? 'Server error occurred'),
        );
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        print('SERVER ERROR : $statusCode');
        print('SERVER ERROR message : ${e.error}');
        print('SERVER ERROR message it self : ${e.message}');

        // Connection issues
        return left(
          ServerFailure(errorMessage: 'Connection failed. Check internet.'),
        );
      } else {
        return left(UnDefinedfailure(errorMessage: 'Allah A3lm'));
      }
    }

}

}
