import 'package:dartz/dartz.dart';
import 'package:habit_tracker/domain/Auth/Entities/AuthUser.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/DataInterfaces/AuthRepoistoryInterface.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/DomainLayerInterfaces/registerInterface.dart';

class RegisterUseCase implements RegisterInterFace
{
  @override
  final AuthRepositoryInterFace repository;

  RegisterUseCase(this.repository);
  @override
Future<Either<ErrorInterface, AuthUser>> execute({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {

    final response = await repository.register(
      username: username,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    // LEGO PIECE: The Fold
    // We 'fold' the result to transform the inner value, 
    // then wrap it back into an 'Either' to satisfy the return type.
    return response.fold(
      (failureObject) => Left(failureObject), // Keep the failure as is
      (successObject) => Right(successObject.toEntity()), // Transform model to entity
    );
}
}
