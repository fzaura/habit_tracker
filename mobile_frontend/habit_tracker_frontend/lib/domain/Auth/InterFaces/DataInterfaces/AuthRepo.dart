import 'package:dartz/dartz.dart';
import 'package:habit_tracker/data/Auth/DataModels/userModelOnRegister.dart';
import 'package:habit_tracker/data/Auth/DataModels/TokenModel.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

abstract class AuthRepositoryInterFace {
  Future<Either<ErrorInterface, UserModel>> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<Either<ErrorInterface, UserModel>> login({
    required String password,
    required String email,
  });


  Future<Either<ErrorInterface, TokenModel>> refreshTokens(
    String oldRefreshToken,
  ); 
  Future<void> logout();
  }


