import 'package:dio/dio.dart';
import 'package:habit_tracker/data/ToDo/DataModels/HabitModel.dart';
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

        print('The whole habit List : ${response.data} and The Count is ${response.data}');

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
    print('THE HABIT ID IS $habitID and THE LENGTH IS ${habitID.length}');

    final regex = RegExp(r'[a-f0-9\-]');
    final strictlyCleanId = habitID
        .trim()
        .toLowerCase()
        .split('')
        .where((char) => regex.hasMatch(char))
        .join('');
    try {
      // 2. Use a leading slash
      print('DEBUG: Calling DELETE on: ${dio.options.baseUrl}');
      print('The STRICLY CLEANED  ID IS :${strictlyCleanId}');
      final response = await dio.delete('habits/$strictlyCleanId');
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
      print(
        '===================== DIO ERROR DEBUG START =====================',
      );

      // 1. THE EXACT URL CALLED
      // Check if there are double slashes like /api//habits or %20 (spaces)
      print('FULL URI: ${e.requestOptions.uri}');
      print('METHOD:   ${e.requestOptions.method}');

      // 2. THE HEADERS (The "Secret" stuff)
      // Check if "Authorization" is actually there and says "Bearer <token>"
      print('HEADERS:  ${e.requestOptions.headers}');

      // 3. THE DATA SENT (Body)
      print('BODY DATA: ${e.requestOptions.data}');

      // 4. THE SERVER'S RESPONSE
      if (e.response != null) {
        print('STATUS CODE: ${e.response?.statusCode}');
        print(
          'SERVER DATA: ${e.response?.data}',
        ); // This usually contains the "Invalid ID" explanation
      } else {
        print('SERVER RESPONSE IS NULL: Likely a timeout or connection issue.');
      }

      // 5. DIO-SPECIFIC ERROR INFO
      print('DIO ERROR TYPE: ${e.type}');
      print('RAW ERROR:      ${e.error}');
      print('STACK TRACE:    ${e.stackTrace}');

      print(
        '===================== DIO ERROR DEBUG END =======================',
      );
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
