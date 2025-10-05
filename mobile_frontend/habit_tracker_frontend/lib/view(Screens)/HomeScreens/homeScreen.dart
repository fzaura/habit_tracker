import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/AddingNewHabitsUtil/stateFulUtil/addNewHabit.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/AddingNewHabitsUtil/stateFulUtil/habitsLister.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/GoalsUtil/StateFulWidgets/goalsCardLister.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/HomeScreenUtil/utilHomeScreenWidgets.dart';
import 'package:habit_tracker/view(Screens)/SeeAllTemp/seeAllTodayHabits.dart';
import 'package:habit_tracker/view_model(Providers)/habitsStateNotifier.dart';
import 'package:intl/intl.dart';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({super.key});
  @override
  ConsumerState<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {
  final String formattedDate = DateFormat(
    'EEE d,MMMM,y',
  ).format(DateTime.now());

  late TextEditingController yourGoalController;
  late TextEditingController yourHabitController;

  void onAddNewHabit() {
    showDialog(context: context, builder: (context) => Addnewhabit());
  }

  @override
  void initState() {
    yourGoalController = TextEditingController();
    yourHabitController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final habitsList = ref.watch(habitSampleProvider);
    final int checkedHabits = habitsList.where((habit) => habit.isCompleted).length;
    final int unCheckedHabits = habitsList.length;

    return Scaffold(
      backgroundColor: Color(0xFFEDEDED),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 49, 139, 52),
              const Color.fromARGB(255, 9, 218, 9),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(28), // FAB radius
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent, //TransParent
          onPressed: () {
            onAddNewHabit();
          },
          shape: CircleBorder(
            side: const BorderSide(color: Colors.white, width: 4),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 48),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: UtilHomeScreenWidgets.homeScreenWelcomeMessage(formattedDate),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            UtilHomeScreenWidgets.homeProgressCard(
              checkedHabits,
              unCheckedHabits,
            ),

            UtilHomeScreenWidgets.todayTemplateContainer(
              listToView: Habitslister(
                seeAll: false,
                shrinkWrap: true,
                canUserScroll: false,
              ),
              nameOfListHeader: 'Today\'s Habits',
              requiredHeight: 400,
              habitsList,
              pressSeeAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeeAllList(
                      nameOfListHeader: 'Today\'s Habits',
                      appBarText: 'Your Habits',
                      listToView: Habitslister(
                        seeAll: true,
                        shrinkWrap: false,
                        canUserScroll: true,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 29),
            UtilHomeScreenWidgets.todayTemplateContainer(
              listToView: GoalsCardLister(
                seeAll: false,
                shrinkWrap: true,
                canUserScroll: false,
              ),
              nameOfListHeader: 'Your Goals',
              habitsList,
              pressSeeAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeeAllList(
                      nameOfListHeader: 'Goals : ',
                      appBarText: 'Your Goals',
                      listToView: GoalsCardLister(
                        seeAll: true,
                        shrinkWrap: false,
                        canUserScroll: true,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    yourGoalController.dispose();
    yourHabitController.dispose();
    super.dispose();
  }
}
