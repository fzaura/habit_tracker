import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/utility/ProgressScreenUtil/statelessWidgets/Detailed%20Goals%20Lister/detailedGoalCard.dart';
import 'package:habit_tracker/data/Models/UIModels/habitUI.dart';
import 'package:habit_tracker/presentation/view(Screens)/ProgressScreen/theGoalInDetail.dart';
import 'package:habit_tracker/domain/Providers/habitsStateNotifier.dart';

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
