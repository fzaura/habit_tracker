import 'package:dartz/dartz.dart';
import 'package:habit_tracker/domain/Auth/Entities/AuthUser.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/DataInterfaces/AuthRepo.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

abstract class RegisterInterFace {
  final AuthRepositoryInterFace repository;

  RegisterInterFace({required this.repository});
  Future<Either<ErrorInterface, AuthUser>> execute({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  });
}
