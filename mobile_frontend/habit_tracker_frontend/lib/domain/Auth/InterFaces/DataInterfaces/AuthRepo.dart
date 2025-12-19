import 'package:dartz/dartz.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

abstract class AuthRepository {
  Future<Either<ErrorInterface, dynamic>> register({
    required String name,
    required String email,
    required String password,
  });
}