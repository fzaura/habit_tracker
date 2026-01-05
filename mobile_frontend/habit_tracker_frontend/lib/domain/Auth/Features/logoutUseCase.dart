// domain/Auth/Features/logoutUseCase.dart
import 'package:habit_tracker/domain/Auth/InterFaces/DataInterfaces/AuthRepoistoryInterface.dart';

class LogoutUseCase {
  final AuthRepositoryInterFace repository;

  LogoutUseCase(this.repository);

  Future<void> execute() async {
    return await repository.logout();
  }
}