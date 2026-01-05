import 'package:dartz/dartz.dart';
import 'package:habit_tracker/data/Auth/DataModels/userModelOnRegister.dart';
import 'package:habit_tracker/domain/Auth/Entities/AuthUser.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/DataInterfaces/AuthRepoistoryInterface.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/DomainLayerInterfaces/loginInterface.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

class LoginUseCase implements LoginInterface {
  @override
  final AuthRepositoryInterFace repository;

  LoginUseCase(this.repository);
  @override
  Future<Either<ErrorInterface, AuthUser>> execute({
    required String email,
    required String password,
  }) async {
    final authUserModel = await repository.login(
      password: password,
      email: email,
    );
    return authUserModel.fold(
      (wrongObject) {
        return Left(wrongObject);
      },
      (rightObject) {
        return Right(rightObject.toEntity());
      },
    );
  }
}
