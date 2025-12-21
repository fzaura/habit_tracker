import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/presentation/Widgets/Cards/Goals%20Cards/goalsCard.dart';
import 'package:habit_tracker/presentation/Habits/Providers/habitsStateNotifier.dart';

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

  Widget emptyGoalsList() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Don't take up the whole screen
          children: [
            Icon(Icons.auto_awesome, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              "Your habit list is looking a bit lonely!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Add your first goal or habit to start building your routine together.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitLister = ref.watch(habitSampleProvider);

    if (habitLister.isEmpty) {
      return emptyGoalsList();
    }

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
}
