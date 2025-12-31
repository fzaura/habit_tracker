import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/Errors/serverFailure.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';
import 'package:habit_tracker/presentation/Widgets/Cards/Goals%20Cards/goalsCard.dart';
import 'package:habit_tracker/presentation/Habits/Providers/habitsStateNotifier.dart';
import 'package:habit_tracker/presentation/Widgets/CircularPercentIndicator/loadingIndicator.dart';
import 'package:habit_tracker/presentation/Widgets/GlobalStateBuilder/habitStateBuilder.dart';
import 'package:habit_tracker/presentation/Widgets/SnackBars/HabitsSnackBar.dart';

class GoalsCardLister extends ConsumerWidget {
  const GoalsCardLister({
    super.key,
    required this.seeAll,
    required this.shrinkWrap,
    required this.canUserScroll,
  });
  final bool seeAll;
  final bool shrinkWrap;
  final bool canUserScroll;

  Widget onSuccess(List<Habit> habitLister, Habit? habit) {
    return Container(
      constraints: BoxConstraints(minHeight: 300, maxHeight: 500),
      child: ListView.builder(
        shrinkWrap: shrinkWrap,
        physics: canUserScroll
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),
        itemCount: (habitLister.length <= 3) || (seeAll)
            ? habitLister.length
            : 3,
        itemBuilder: (context, index) {
          final habitToDisplay = habitLister[index];
          return GoalsCard(
            key: ValueKey(habitLister[index]),
            habitGoals: habitToDisplay,
          );
        },
      ),
    );
  }

  Widget onFailure(ErrorInterface error) {
    return HabitASnackBar(message: error.errorMessage);
  }

  Widget onErrorFailure() {
    return HabitASnackBar(
      message: 'Failed to Add New Habit',
      icon: Icons.wrong_location_outlined,
    );
  }

  Widget loadWidget() {
    return HabitLoadingIndicator();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(habitsProvider);

    // if (habitLister.isEmpty) {
    //   return Emptylists.emptyGoalsList(
    //     mainMessage: 'Your Goals List Is Looking a Bit Lonely!',
    //     secondMessage:
    //         'Add your First Goal or Habit to Start Building Your Routine Together',
    //   );
    // }

    return HabitStateBuilder(
      state: state,
      successWidget: onSuccess,
      failureWidget: onErrorFailure(),
      loadingWidget: loadWidget(),
      providedError: ServerFailure(errorMessage: 'YEs'),
    );
  }
}
