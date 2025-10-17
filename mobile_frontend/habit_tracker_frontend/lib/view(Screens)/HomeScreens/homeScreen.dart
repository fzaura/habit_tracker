import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/AddingNewHabitsUtil/stateFulUtil/addNewHabit.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/AddingNewHabitsUtil/stateFulUtil/habitsLister.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/GoalsUtil/StateFulWidgets/goalsCardLister.dart';
import 'package:habit_tracker/core/utility/HomeScreenUtils/HomeScreenUtil/utilHomeScreenWidgets.dart';
import 'package:habit_tracker/view_model(Providers)/habitsStateNotifier.dart';
import 'package:intl/intl.dart';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({super.key});
  @override
  ConsumerState<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {
  final String formattedDate = DateFormat(
    'EEE d,MMM,y',
  ).format(DateTime.now());

final String formattedDateAfterAWeek = DateFormat(
    'EEE d,MMM,y',
  ).format(DateTime.now().add(Duration(days: 7)));
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
    final int checkedHabits = habitsList
        .where((habit) => habit.isCompleted)
        .length;
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
        toolbarHeight: 100,
        title: UtilHomeScreenWidgets.homeScreenWelcomeMessage(formattedDate, formattedDateAfterAWeek),
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
                UtilHomeScreenWidgets.takeToSeeAllPage(
                  ctxt: context,
                  nameOfListHeader: 'Today\'s Habits',
                  appBarText: 'Your Habits ',
                  showHorizentalCalendar: true,
                  lister: Habitslister(
                    seeAll: false,
                    shrinkWrap: true,
                    canUserScroll: false,
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
                UtilHomeScreenWidgets.takeToSeeAllPage(
                  ctxt: context,
                  nameOfListHeader: '',
                  appBarText: 'Your Goals ',
                  showHorizentalCalendar: true,
                  lister: GoalsCardLister(
                    seeAll: true,
                    shrinkWrap: true,
                    canUserScroll: true,
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
