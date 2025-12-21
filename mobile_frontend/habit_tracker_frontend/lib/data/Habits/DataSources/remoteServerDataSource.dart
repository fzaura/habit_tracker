import 'package:dio/dio.dart';
import 'package:habit_tracker/data/DataModels/HabitModel.dart';
import 'package:habit_tracker/domain/Entities/habitUI.dart';
import 'package:habit_tracker/domain/InterFaces/DataLayerInterfaces/DataSourcesInterfaces/dataSourceInterface.dart';


class RemoteServerDataSource extends DataSourceInterface {
  final Dio dio; //Because we need to use it
  const RemoteServerDataSource({required this.dio});

  @override
  Future<List<HabitModel>> getHabits() async {
    //We Are going to Make the Response
    print("🚀 [DEBUG] loadNewHabits started");
    try {
      print("🚀 [DEBUG] Calling getHabitsList...");
      final response = await dio.get('/habits');
      //Let's See the Results of the DIO.
      print('The response Status Code : ${response.statusCode}');

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((jsonData) => HabitModel.fromJson(jsonData))
            .toList();
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
}
