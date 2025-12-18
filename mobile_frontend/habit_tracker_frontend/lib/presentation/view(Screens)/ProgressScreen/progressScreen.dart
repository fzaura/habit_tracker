import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';
import 'package:habit_tracker/presentation/Providers/habitsStateNotifier.dart';
import 'package:habit_tracker/presentation/Widgets/Cards/Headers/homeScreenProgressReport.dart';
import 'package:habit_tracker/presentation/Widgets/Container/ProgressScreen/YourGoalsConatiner.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  int numberOfAchievedGoals(List<Habit> habitList) {
    return habitList.where((habit) => habit.isGoalAchieved).length;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsList = ref.watch(habitSampleProvider);

    return Scaffold(
      backgroundColor: Color(0xFFEDEDED),
      appBar: (AppBar(
        backgroundColor: Color(0xFFEDEDED),
        toolbarHeight: 80,
        title: HomeScreenProgressReport(),//Header of the Screen 
      )),
      body: YourGoalsConatiner(
        numberOfAchievedGoals: numberOfAchievedGoals(habitsList),
        allGoals: habitsList.length,
      ),
    );
  }
}
