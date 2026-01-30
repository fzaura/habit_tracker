import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/domain/Habits/Features/DeleteHabits/confirmDelete.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';
import 'package:habit_tracker/presentation/Habits/DataBundles/homeScreenDataBundle.dart';
import 'package:habit_tracker/presentation/Widgets/Cards/To%20do%20Cards/to_do_card.dart';
import 'package:habit_tracker/presentation/Widgets/SnackBars/HabitsSnackBar.dart';
import 'package:habit_tracker/presentation/Habits/Providers/habitsStateNotifier.dart';
import 'package:habit_tracker/presentation/Widgets/CircularPercentIndicator/loadingIndicator.dart';
import 'package:habit_tracker/presentation/Widgets/GlobalStateBuilder/habitStateBuilder.dart';

class ToDoLister extends ConsumerWidget {
  const ToDoLister({
    super.key,
    required this.seeAll,
    required this.shrinkWrap,
    required this.canUserScroll,
  });
  final bool seeAll;
  final bool shrinkWrap;
  final bool canUserScroll;

  Widget onSuccessWidget(HabitHomeScreenDataBundle bundle) {
   
      bundle.habitsToList
          .map((h) => 'ID: ${h.id} | Name: ${h.habitName}')
          .toList();
    

    return Container(
      constraints: BoxConstraints(minHeight: 300, maxHeight: 450),
      child: ListView.builder(
        physics: canUserScroll
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),
        shrinkWrap: shrinkWrap,
        itemCount: seeAll || (bundle.habitsToList.length <= 3)
            ? bundle.habitsToList.length
            : 3,
        itemBuilder: (context, index) {
          final habit = bundle.habitsToList[index];
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
            key: ValueKey(bundle.habitsToList[index].id),
            child: ToDoCard(taskName: habit.habitName),
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

  Widget onFailureObject(ErrorInterface error) {

    return HabitASnackBar(
      message: 'Failed to Add New Habit',
      icon: Icons.wrong_location_outlined,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(habitsProvider);

    return HabitStateBuilder(
      state: state,
      successHomeScreenWidget: onSuccessWidget,
      failureWidget: onFailureObject,
      loadingWidget: onLoadingWidget(),
    );
  }
}
