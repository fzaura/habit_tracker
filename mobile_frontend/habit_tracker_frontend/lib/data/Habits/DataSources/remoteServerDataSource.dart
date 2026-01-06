import 'package:dio/dio.dart';
import 'package:habit_tracker/data/Habits/DataModels/HabitModel.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DataLayerInterfaces/DataSourcesInterfaces/dataSourceInterface.dart';

class RemoteServerDataSource extends DataSourceInterface {
  final Dio dio; //Because we need to use it
  const RemoteServerDataSource({required this.dio});

  @override
  Future<List<HabitModel>> getHabits() async {
    //We Are going to Make the Response
    print("🚀 [DEBUG] loadNewHabits started");
    try {
      print("🚀 [DEBUG] Calling getHabitsList...");
      final response = await dio.get('habits');
      //Let's See the Results of the DIO.

      if (response.statusCode == 200) {
        print('The response Status Code : ${response.statusCode}');

        print('The whole habit List : ${response.data}');

        return HabitModel.fromJsonToModels(response.data);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        error: 'Failed to Fetch Habits  ${response.statusCode}',
      );
    } on DioException catch (e) {
      print('The Error is ${e.error}');
      throw e;
    }
  }

  @override
  Future<HabitModel> addNewHabit(HabitModel newHabit) async {
    try {
      final response = await dio.post('habits', data: newHabit);
      //The Habit dio Calls the To json methods automatically
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        return (HabitModel.fromJson(response.data, false));
        //Return the New Habit ID to the Front So We can update it with the NEW
        //ID and have our habits in sync.
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Error Occured At the Remote Data Server',
        );
      }
    } on DioException catch (e) {
      print('Habit Add Failed: ${e.response?.data}');
      rethrow;
    }
  }

  @override
  Future<String> deleteHabit(String habitID) async {
    try {
      final response = await dio.delete('habits/$habitID');
      //The Habit dio Calls the To json methods automatically
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        return response.data.toString();
        //Return the New Habit ID to the Front So We can update it with the NEW
        //ID and have our habits in sync.
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Error Occured At the Remote Data Server',
        );
      }
    } on DioException catch (e) {
      print('Habit Add Failed: ${e.response?.data}');
      rethrow;
    }
  }

  @override
  Future<String> editHabit(HabitModel habit) async {
    //The Only thing that the Backend Updates is the Backend Name
    try {
      //We want to return the newly ediited habit so we have synced data.
      final response = await dio.put(
        'habits/${habit.id}',
        data: {'name': habit.habitName},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(
          'The Response Data at the Remote Server Data Source is : ${response.data}',
        );
        return response.data.toString();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Error Occured At the Remote Data Server',
        );
      }
    } on DioException catch (e) {
      print('Habit Editting Failed: ${e.response?.data}');
      rethrow;
    }
  }
}
