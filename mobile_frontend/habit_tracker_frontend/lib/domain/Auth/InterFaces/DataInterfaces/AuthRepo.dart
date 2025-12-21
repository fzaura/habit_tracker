import 'package:dartz/dartz.dart';
import 'package:habit_tracker/data/Auth/DataModels/userModelOnRegister.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

abstract class AuthRepositoryInterFace {
  Future<Either<ErrorInterface, UserModelOnRegister>> register({
    required String username,
    required String email,
    required String password,
        required String confirmPassword,

  });
}