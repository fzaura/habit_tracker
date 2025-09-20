import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/utility/stateFulUtil/habitsCheckCard.dart';
import 'package:habit_tracker/view_model(Providers)/habitsStateNotifier.dart';

class Habitslister extends ConsumerWidget {
  const Habitslister({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsToList = ref.watch(habitSampleProvider);
    return ListView.builder(
      itemCount: habitsToList.length,
      itemBuilder: (context, index) {
        final habit = habitsToList[index];
        return Habitscheckcard(habitToDisplay: habit);
      },
    );
  }
}
