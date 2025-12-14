import 'dart:convert';

import 'package:habit_tracker/core/API/api.dart';
import 'package:habit_tracker/core/utility/Format/formatNames.dart';
import 'package:habit_tracker/data/DataModels/HabitModel.dart';
import 'package:habit_tracker/domain/Entities/habitUI.dart';
import 'package:habit_tracker/domain/InterFaces/DataLayerInterfaces/RepoInterfaces/habitRepoInterface.dart';
import 'package:http/http.dart' as http;

Map<String, dynamic> _convertHabitsTojson(Habit habitToConvert) {
  final periodString = FormatNames.mapPeriodUnitToString(
    habitToConvert.periodUnit,
  );

  return {
    // Keys MUST match your Node.js/Mongoose schema field names
    'name': habitToConvert.habitName,
    'goal': habitToConvert.goalName,

    // Construct the nested frequency object expected by the server
    'frequency': FrequencyModel(
      type: periodString,
      // Only send daysOfWeek if the frequency type is weekly
      daysOfWeek: habitToConvert.periodUnit == EnperiodUnit.weekly
          ? habitToConvert.certainDaysOfWeek
          : const [],
    ).toJson(),

    // Format the DateTime to a standard ISO string for server consumption
    'endDate': habitToConvert.endedAt?.toIso8601String(),
  };
}

class HabitRepo implements HabitRepoInterface {
  @override
  Future<bool> createHabit(Habit habitToCreate) async {
    try {
      final Map<String, dynamic> convertedHabit = _convertHabitsTojson(
        habitToCreate,
      );
      final response = await http.post(
        Api.url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(convertedHabit),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(response.body);
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

@override
  Future<List<HabitModel>> listHabits() async {
    List<HabitModel> habits = [];
    try {
      final response = await http.get(
        Api.url,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.body == {}) {
        return habits;
      } else if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String,dynamic> unDecodedData=json.decode(response.body);
      habits=  HabitModel.fromJsonToModels(unDecodedData);
      return habits;

      } else {
        return habits;
      }
    } catch (e) {
      return habits;
    }
  }

  //   Future<Habit> updateHabit(Habit habit)
  //  async {

  //   }

  //   // 4. DELETE (DELETE)
  //   // Defines the method signature for removing a habit by its ID.
  //   Future<bool> deleteHabit(String id)
  //   async{

  //   }

  //   // 5. CUSTOM ACTION (POST for Completion)
  //   // Defines the method signature for marking a habit as complete on a specific date.
  //   Future<bool> completeHabit(String habitId, DateTime date)
  //  async {

  //   }
}
