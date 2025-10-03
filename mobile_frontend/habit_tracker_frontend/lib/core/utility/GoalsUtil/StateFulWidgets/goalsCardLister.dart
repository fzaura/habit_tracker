import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/utility/GoalsUtil/StateLessWidgets/goalsCard.dart';
import 'package:habit_tracker/view_model(Providers)/habitsStateNotifier.dart';

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
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: canUserScroll
          ? AlwaysScrollableScrollPhysics()
          : NeverScrollableScrollPhysics(),
      itemCount: (habitLister.length <= 3) || (seeAll == true)
          ? habitLister.length
          : 3,
      itemBuilder: (context, index) {
        final habitToDisplay = habitLister[index];
        return GoalsCard(
          key: ValueKey(habitLister[index]),
          habitGoals: habitToDisplay,
        );
      },
    );
  }
}
