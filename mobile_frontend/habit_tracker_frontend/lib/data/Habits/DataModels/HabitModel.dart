// Assumed in: lib/features/habit_management/data/models/habit_model.dart

// 1. Helper to map Mongoose String to Frontend Enum
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utility/Format/formatNames.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';
import 'package:intl/intl.dart';

class FrequencyModel {
  final String type;
  final List<int> daysOfWeek;

  FrequencyModel({required this.type, required this.daysOfWeek});

  // DESERIALIZATION: JSON -> Dart
  factory FrequencyModel.fromJson(Map<String, dynamic> json) {
    return FrequencyModel(
      type: json['type'] as String,
      daysOfWeek: List<int>.from(json['daysOfWeek'] as List),
    );
  }

  // SERIALIZATION: Dart -> JSON
  Map<String, dynamic> toJson() {
    return {'type': type, 'daysOfWeek': daysOfWeek};
  }
}

class HabitModel {
  // Fields match the JSON keys from the Node.js/Mongoose response
  final String id;
  final String habitName; // Corresponds to Entity's habitName
  final String goal;
  final Map<String, dynamic> frequency; // Holds the raw frequency object
  final String? endDate; // ISO Date String
  final String createdAt; // ISO Date String
  final String updatedAt; // ISO Date String
  final String status; // From the backend's virtual field

  // Note: We don't include userId as the frontend ignores it.

  //This is the Normal Constrcutor
  HabitModel({
    required this.id,
    required this.habitName,
    required this.goal,
    required this.frequency,
    this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  // 🏭 DESERIALIZATION (JSON -> HabitModel)
  //factory Constructor
  factory HabitModel.fromJson(Map<String, dynamic> json, bool fromList) {

    if(fromList==false){
    // 1. Zoom into the 'habit' object first
    final data = json['habit'] as Map<String, dynamic>;
        // 2. Now use 'data' to get the actual values

     return HabitModel(
      id: data['id'].toString(),
      habitName: data['name'] as String,
      goal: data['goal'] as String,
      frequency: data['frequency'] as Map<String, dynamic>,
      endDate: data['endDate'] as String?,
      createdAt: data['createdAt'] as String,
      updatedAt: data['updatedAt'] as String,
      status: data['status'] as String? ?? 'active',
    );
    }
    else{
      return HabitModel(
      id: json['id'].toString(),
      habitName: json['name'] as String,
      goal: json['goal'] as String,
      frequency: json['frequency'] as Map<String, dynamic>,
      endDate: json['endDate'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      status: json['status'] as String? ?? 'active',
    );
    }
   

  }

  // ➡️ COMPOSITION METHOD (HabitModel -> HabitEntity)
  // This is the CRITICAL step that converts the network format
  // into the Domain format.
  Habit toEntity() {
    final frequencyModel = FrequencyModel.fromJson(frequency);

    return Habit(
      // --- MAPPING JSON FIELDS TO ENTITY FIELDS ---
      id: id, // Mongoose _id -> Entity id
      habitName: habitName, // Mongoose name -> Entity habitName
      goalName: goal,

      // Mapping Backend String -> Frontend Enum
      periodUnit: FormatNames.mapStringToPeriodUnit(frequencyModel.type),

      // Mongoose doesn't define these, so we use your Entity's default/placeholders
      habitType: EnhabitGoal.buildHabit,
      targettedPeriod: 21,
      isCompleted: false,
      currentStreak: 0,
      bestStreak: 0,
      isGoalAchieved: false,
      completedDates: const [],
      icon: Icons.access_alarms_rounded,
      // Converting ISO String Dates to Dart DateTime
      endedAt: DateTime.now().add(Duration(days: 21)),
      updatedAt: DateTime.parse(updatedAt),
      createdAt: DateTime.parse(createdAt),
    );
  }

  static List<Habit> toHabits(List<HabitModel> models) {
    final List<Habit> normalHabits = [];
    for (final habit in models) {
      normalHabits.add(habit.toEntity());
    }
    return normalHabits;
  }

 static List<HabitModel> fromJsonToModels(Map<String, dynamic> responseBody) {
    //1-Navigate to the List
    final List actualList = responseBody['info']['data'];
    return actualList.map((model) => HabitModel.fromJson(model,true)).toList();
  }

  // 📝 SERIALIZATION (HabitModel -> JSON for POST/PUT)
  // Converts the Entity back to the structure the server expects (usually done
  Map<String, dynamic> toJson() {
    return {
      "name": habitName,
      "goal": goal,
      "endDate": endDate,
      "frequency": frequency,
    };
  }

  // 🏭 CONVERTER: Habit (Entity) -> HabitModel (Data)
  static HabitModel fromEntity(Habit habit) {
    return HabitModel(
      id: habit.id,
      habitName: habit.habitName,
      goal: habit.goalName,
      // We reconstruct the frequency Map for the model
      frequency: {
        'type': FormatNames.mapPeriodUnitToString(habit.periodUnit),
        'daysOfWeek': habit.certainDaysOfWeek,
      },
      endDate: DateFormat('yyyy-MM-dd').format(habit.endedAt!),
      createdAt: DateFormat('yyyy-MM-dd').format(habit.createdAt),
      updatedAt: DateFormat('yyyy-MM-dd').format(habit.updatedAt),
      status: habit.isGoalAchieved ? 'completed' : 'active',
    );
  }
}
