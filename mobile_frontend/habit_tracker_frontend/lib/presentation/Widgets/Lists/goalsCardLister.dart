import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/presentation/Widgets/Cards/Goals%20Cards/goalsCard.dart';
import 'package:habit_tracker/presentation/Providers/habitsStateNotifier.dart';

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
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitLister = ref.watch(habitSampleProvider);
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
