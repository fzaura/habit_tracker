import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/utility/AddingNewHabitsUtil/stateFulUtil/habitsCheckCard.dart';
import 'package:habit_tracker/view_model(Providers)/habitsStateNotifier.dart';

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsToList = ref.watch(habitSampleProvider);
    return ListView.builder(
      physics: canUserScroll
          ? AlwaysScrollableScrollPhysics()
          : NeverScrollableScrollPhysics(),
      shrinkWrap: shrinkWrap,
      itemCount: seeAll || (habitsToList.length <= 3) ? habitsToList.length : 3,
      itemBuilder: (context, index) {
        final habit = habitsToList[index];
        return Habitscheckcard(
          key: ValueKey(habitsToList[index]),
          habitToDisplay: habit,
        );
      },
    );
  }
}
