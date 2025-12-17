
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:habit_tracker/core/Errors/accessDeniedFailure.dart';
import 'package:habit_tracker/core/Errors/serverFailure.dart';
import 'package:habit_tracker/core/Errors/undefinedFailure.dart';
import 'package:habit_tracker/data/DataModels/HabitModel.dart';
import 'package:habit_tracker/data/DataSources/remoteServerDataSource.dart';
import 'package:habit_tracker/domain/InterFaces/DataLayerInterfaces/RepoInterfaces/habitRepoInterface.dart';
import 'package:habit_tracker/domain/InterFaces/ErrorInterface/errorInterface.dart';



class HabitRepo implements HabitRepoInterface {
  final RemoteServerDataSource dataSource;
  const HabitRepo({required this.dataSource});
  @override
  Future<Either<ErrorInterface, List<HabitModel>>> getHabits() async {
    try {
      final habits = await dataSource.getHabits();
      return right(habits);
    } on DioException catch (e) {
      // 3. FAILURE: Catch the technical exception and map it

      final statusCode = e.response?.statusCode;

      if (statusCode == 401 || statusCode == 403) {
        // 401/403: Indicates token/permission failure
        return left(AccessDeniedfailure(errorMessage: ''));
      } else if (statusCode != null && statusCode >= 500) {
        // 500-599: Server-side issue
        return left(
          ServerFailure(errorMessage: e.message ?? 'Server error occurred'),
        );
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        // Connection issues
        return left(
          ServerFailure(errorMessage: 'Connection failed. Check internet.'),
        );
       
      }
      else
      {
        return left(UnDefinedfailure(errorMessage: 'Allah A3lm'));
      }
    }
  }
}
