import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/utility/NullOrEmptyMessages/emptyLists.dart';
import 'package:habit_tracker/presentation/Widgets/Cards/Goals%20Cards/detailedGoalCard.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';
import 'package:habit_tracker/presentation/Habits/Screens/ProgressScreen/theGoalInDetail.dart';
import 'package:habit_tracker/presentation/Habits/Providers/habitsStateNotifier.dart';

class Detailedgoalslister extends ConsumerWidget {
  const Detailedgoalslister({
    super.key,
    required this.canUserScroll,
    required this.seeAll,
    required this.shrinkWrap,
  });
  final bool seeAll;
  final bool shrinkWrap;
  final bool canUserScroll;

  void goToGoalInDetail(BuildContext context, Habit habit) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TheGoalInDetail(habit: habit)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitSampleProvider);
    if (habits.isEmpty) {
      return Emptylists.emptyGoalsList(
        mainMessage: 'Your Goal List Is Looking a bit lonely',
        secondMessage:
            'Add Your First Goal or Habit to Start Building your Routine Together !',
      );
    }

    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: canUserScroll
          ? AlwaysScrollableScrollPhysics()
          : NeverScrollableScrollPhysics(),
      itemCount: habits.length <= 3 || (seeAll) ? habits.length : 3,
      itemBuilder: (context, index) => InkWell(
        child: DetailedGoalCard(
          key: ValueKey(index),
          habitToDisplay: habits[index],
        ),
        onTap: () {
          goToGoalInDetail(context, habits[index]);
        },
      ),
    );
  }
}
