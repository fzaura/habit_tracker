import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/utility/GoalsUtil/StateLessWidgets/goalsCard.dart';
import 'package:habit_tracker/view_model(Providers)/habitsStateNotifier.dart';

class GoalsCardLister extends ConsumerWidget {
  const GoalsCardLister({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitLister = ref.watch(habitSampleProvider);
    return ListView.builder(
      itemCount: habitLister.length,
      itemBuilder: (context, index) {
        final habitToDisplay = habitLister[index];
        return GoalsCard(habitGoals: habitToDisplay);
      },
    );
  }
}
