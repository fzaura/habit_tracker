import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtil/utilHomeScreenWidgets.dart';
import 'package:habit_tracker/core/utility/SeeAllUtil/StateFulWidgets/singleWeekRow.dart';
import 'package:habit_tracker/view_model(Providers)/habitsStateNotifier.dart';

class SeeAllTodayHabits extends ConsumerWidget {
  const SeeAllTodayHabits({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsList = ref.watch(habitSampleProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Habits : ',
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 350, height: 100, child: SingleWeekRow()),
            UtilHomeScreenWidgets.todayHabitContainer(
              habitsList,
              seeAllHabits: true,
              shrinkWrap: false,
              requiredHeight: 400,
            ),
          ],
        ),
      ),
    );
  }
}
