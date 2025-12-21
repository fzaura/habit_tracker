import 'package:dartz/dartz.dart';
import 'package:habit_tracker/domain/Auth/Entities/AuthUser.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/DataInterfaces/AuthRepo.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

abstract class LoginInterface {
  final AuthRepositoryInterFace repository;

  LoginInterface({required this.repository});
  Future<Either<ErrorInterface, AuthUser>> execute({
    required String email,
    required String password,
  });
}
