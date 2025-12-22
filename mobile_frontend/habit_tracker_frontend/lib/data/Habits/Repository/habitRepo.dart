import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:habit_tracker/core/Errors/accessDeniedFailure.dart';
import 'package:habit_tracker/core/Errors/serverFailure.dart';
import 'package:habit_tracker/core/Errors/undefinedFailure.dart';
import 'package:habit_tracker/data/Habits/DataModels/HabitModel.dart';
import 'package:habit_tracker/data/Habits/DataSources/remoteServerDataSource.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DataLayerInterfaces/RepoInterfaces/habitRepoInterface.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

class HabitRepo implements HabitRepoInterface {
  final RemoteServerDataSource dataSource;
  const HabitRepo({required this.dataSource});
  @override
  Future<Either<ErrorInterface, List<HabitModel>>> getHabits() async {
    try {
      final habits = await dataSource.getHabits();
      print(habits);
      return right(habits); //A Lits of Habit Models
    } on DioException catch (e) {
      // 3. FAILURE: Catch the technical exception and map it

      final statusCode = e.response?.statusCode;

      if (statusCode == 401 || statusCode == 403) {
        // 401/403: Indicates token/permission failure
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
  Future<Either<ErrorInterface, HabitModel>> addNewHabit(HabitModel newHabit) async{
    try {
      final habits = await dataSource.addNewHabit(newHabit);
      print(newHabit);
      return right(habits); //A Lits of Habit Models
    } on DioException catch (e) {
      // 3. FAILURE: Catch the technical exception and map it

      final statusCode = e.response?.statusCode;

      if (statusCode == 401 || statusCode == 403) {
        // 401/403: Indicates token/permission failure
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
