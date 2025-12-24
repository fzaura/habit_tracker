import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/Errors/serverFailure.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';
import 'package:habit_tracker/domain/Habits/Features/DeleteHabits/confirmDelete.dart';
import 'package:habit_tracker/presentation/SnackBars/HabitsSnackBar.dart';
import 'package:habit_tracker/presentation/Widgets/Cards/Habit%20Cards/habitsCheckCard.dart';
import 'package:habit_tracker/presentation/Habits/Providers/habitsStateNotifier.dart';
import 'package:habit_tracker/presentation/Widgets/CircularPercentIndicator/loadingIndicator.dart';
import 'package:habit_tracker/presentation/Widgets/GlobalStateBuilder/habitStateBuilder.dart';

class Habitslister extends ConsumerWidget {
  const Habitslister({
    super.key,
    required this.seeAll,
    required this.shrinkWrap,
    required this.canUserScroll,
  });
  final bool seeAll;
  final bool shrinkWrap;
  final bool canUserScroll;

  Widget onSuccessWidget(List<Habit> habitsToList, Habit? habit) {
    print(
      habitsToList.map((h) => 'ID: ${h.id} | Name: ${h.habitName}').toList(),
    );

    return Container(
      constraints: BoxConstraints(minHeight: 300, maxHeight: 450),
      child: ListView.builder(
        physics: canUserScroll
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),
        shrinkWrap: shrinkWrap,
        itemCount: seeAll || (habitsToList.length <= 3)
            ? habitsToList.length
            : 3,
        itemBuilder: (context, index) {
          final habit = habitsToList[index];
          return Dismissible(
            background: Container(
              width: 335,
              height: 58,
              color: const Color.fromARGB(255, 241, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {}, // Delete action
                    icon: Icon(Icons.delete, color: Colors.black),
                  ),
                ],
              ),
            ),
            key: ValueKey(habitsToList[index].id),
            child: Habitscheckcard(
              key: ValueKey(habitsToList[index].id),
              habitToDisplay: habit,
            ),
            onDismissed: (direction) {
              showDialog(
                context: context,
                builder: (context) => ConfirmDelete(toDeleteHabitId: habit.id),
              );
            },
          );
        },
      ),
    );
  }

  Widget onLoadingWidget() {
    return Center(child: HabitLoadingIndicator());
  }

  Widget onFailureObject() {
    return HabitaSnackBar(message: 'Failed to Add New Habit',icon: Icons.wrong_location_outlined,);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(habitsProvider);
    // 2. Use Pattern Matching to find the list

    // final habitsToList = ref.watch(habitsProvider.notifier).habitsList;
    // if (habitsToList.isEmpty) {
    //   return Emptylists.emptyGoalsList(
    //     mainMessage: 'Your Habit List Is Looking a Bit Lonely!',
    //     secondMessage:
    //         'Add Your First Habit so we can start building your routine',
    //   );
    // }
    return HabitStateBuilder(
      state: state,
      successWidget: onSuccessWidget,
      failureWidget: onFailureObject(),
      loadingWidget: onLoadingWidget(),
      providedError: ServerFailure(errorMessage: 'nega'),
    );
  }
}
