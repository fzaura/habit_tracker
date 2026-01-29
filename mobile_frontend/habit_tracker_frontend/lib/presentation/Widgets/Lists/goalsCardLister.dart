import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/Errors/serverFailure.dart';
import 'package:habit_tracker/data/Habits/Dummy%20Data/dummy_data_goal_card.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';
import 'package:habit_tracker/presentation/Habits/DataBundles/homeScreenDataBundle.dart';
import 'package:habit_tracker/presentation/Widgets/Cards/Goals%20Cards/goal_card.dart';
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

  /// Builds the goal cards list vertically
  /// 
  /// RESPONSIBILITY: Single - Layout composition
  /// Uses dummy data for testing - easily switchable to real data
  Widget onSuccess(HabitHomeScreenDataBundle bundle) {
    final goalCards = DummyGoalCardData.dummyGoalCards;

    return Container(
      constraints: const BoxConstraints(minHeight: 300, maxHeight: 500),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: shrinkWrap,
        physics: canUserScroll
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemCount: goalCards.length,
        itemBuilder: (context, index) {
          final goalCard = goalCards[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            child: GoalCard(
              cardIndex: index,
              goalName: goalCard.goalName,
              taskName: goalCard.taskName,
              category: goalCard.category,
              icon: goalCard.icon,
              progressData: goalCard.progressData,
            ),
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
      message: 'Failed to Load Goals',
      icon: Icons.wrong_location_outlined,
    );
  }

  Widget loadWidget() {
    return const HabitLoadingIndicator();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(habitsProvider);

    return HabitStateBuilder(
      state: state,
      successHomeScreenWidget: onSuccess,
      failureWidget: onErrorFailure(),
      loadingWidget: loadWidget(),
      providedError: ServerFailure(errorMessage: 'Failed to load goals'),
    );
  }
}