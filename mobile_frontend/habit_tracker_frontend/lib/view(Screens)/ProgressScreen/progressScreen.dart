import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/utility/ProgressScreenUtil/statelessWidgets/Detailed%20Goals%20Lister/utilProgressScreen.dart';
import 'package:habit_tracker/data/Models/UIModels/habitUI.dart';
import 'package:habit_tracker/view_model(Providers)/habitsStateNotifier.dart';

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
        title: Utilprogressscreen.homeScreenProgressReport(),//Header of the Screen 
      )),
      body: Utilprogressscreen.yourGoalsContainer(
        ctxt: context,
        numberOfAchievedGoals: numberOfAchievedGoals(habitsList),
        allGoals: habitsList.length,
      ),
    );
  }
}
