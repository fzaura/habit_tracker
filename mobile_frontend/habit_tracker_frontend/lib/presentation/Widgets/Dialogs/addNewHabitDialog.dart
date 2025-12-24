import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/presentation/Widgets/Forms/addANewHabitForm.dart';

class AddnewhabitDialog extends ConsumerStatefulWidget {
  const AddnewhabitDialog({super.key});
  @override
  ConsumerState<AddnewhabitDialog> createState() => _AddnewhabitState();
}

class _AddnewhabitState extends ConsumerState<AddnewhabitDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(child: AddANewHabitForm());
  }

  @override
  void dispose() {
    super.dispose();
  }
}
