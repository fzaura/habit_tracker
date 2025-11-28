import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/domain/Features/SeeAllHabitsFeature/StateFulWidgets/singleWeekRow.dart';
import 'package:habit_tracker/domain/Providers/habitsStateNotifier.dart';
import 'package:habit_tracker/presentation/Widgets/Container/HomeScreen/todayTempContainer.dart';

class SeeAllList extends ConsumerWidget {
  const SeeAllList({
    super.key,
    required this.appBarText,
    required this.nameOfListHeader,
    required this.listToView,
    required this.seeHorizentalCalendar,
  });
  final String appBarText;
  final String nameOfListHeader;
  final Widget listToView;
  final bool seeHorizentalCalendar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsList = ref.watch(habitSampleProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarText,
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (seeHorizentalCalendar)
              SizedBox(width: 350, height: 100, child: SingleWeekRow()),

            TodayTempContainer(
              habits: habitsList,
              seeAllButton: true,
              pressSeeAll: () {},//This Is Probably Wrong 
              nameOfListHeader: nameOfListHeader,
              listToView: listToView,
              requiredHeight: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
