import 'package:habit_tracker/data/DataModels/HabitModel.dart';
import 'package:habit_tracker/domain/InterFaces/DataLayerInterfaces/DataSourcesInterfaces/dataSourceInterface.dart';
import 'package:http/http.dart' as http;

class RemoteServerDataSource extends DataSourceInterface {
  Future<List<HabitModel>> getHabits()
  async{
   final List<HabitModel> habitModels=[];
   
   return habitModels;
  }
}