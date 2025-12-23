import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/presentation/Auth/Providers/authProvider.dart';
import 'package:habit_tracker/presentation/Auth/State/authState.dart';
import 'package:habit_tracker/presentation/Auth/State/habitsState.dart';
import 'package:habit_tracker/presentation/Widgets/Cards/HomeScreenCards/HomeScreenWelcomeCard.dart';
import 'package:habit_tracker/presentation/Widgets/Dialogs/addNewHabitDialog.dart';
import 'package:habit_tracker/presentation/Widgets/Title/HomeScreenWelcomeMessage.dart';
import 'package:habit_tracker/presentation/Widgets/Container/HomeScreen/todayTempContainer.dart';
import 'package:habit_tracker/presentation/Widgets/Lists/habitsLister.dart';
import 'package:habit_tracker/presentation/Widgets/Lists/goalsCardLister.dart';
import 'package:habit_tracker/presentation/Habits/Providers/habitsStateNotifier.dart';
import 'package:habit_tracker/presentation/Habits/Screens/SeeAllTemp/seeAllTodayHabits.dart';
import 'package:intl/intl.dart';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({super.key});
  @override
  ConsumerState<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen>
    with SingleTickerProviderStateMixin {
  takeToSeeAllPage({
    required BuildContext ctxt,
    required String nameOfListHeader,
    required String appBarText,
    required Widget lister,
    required bool showHorizentalCalendar,
  }) {
    Navigator.push(
      ctxt,
      MaterialPageRoute(
        builder: (context) => SeeAllList(
          nameOfListHeader: nameOfListHeader,
          appBarText: appBarText,
          listToView: lister,
          seeHorizentalCalendar: showHorizentalCalendar,
        ),
      ),
    );
  }

  final String formattedDate = DateFormat(
    'EEE, MMM ,yyy',
  ).format(DateTime.now()); // Fri, Oct 17

  final String formattedDateAfterAWeek = DateFormat(
    'd/M/y',
  ).format(DateTime.now().add(Duration(days: 7)));

  void onAddNewHabit() {
    showDialog(context: context, builder: (context) => AddnewhabitDialog());
  }

  late AnimationController _animationcontroller;

  @override
  void initState() {
    _animationcontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationcontroller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final habitsState = ref.watch(habitsProvider.notifier).habitsList;
    final authState=ref.watch(authProvider);
    final String displayUsername = (authState is AuthSuccess) 
        ? authState.user.username 
        : "Guest";
        
    final int checkedHabits = habitsState
        .where((habit) => habit.isCompleted)
        .length;
    final int unCheckedHabits = habitsState.length;

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
        title: HomeScreenWelcomeMessage(
          formattedDate: formattedDate,
          username:displayUsername ,
          formattedDateAfterAWeek: formattedDateAfterAWeek,
        ),
      ),
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          builder: (context, child) => SlideTransition(
            position: _animationcontroller.drive(
              Tween(begin: const Offset(0, 0.4), end: const Offset(0, 0)),
            ),
            child: child,
          ),
          animation: _animationcontroller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              HomeScreenWelcomeCard(
                habitsCheckedToday: checkedHabits,
                allTheHabits: unCheckedHabits,
              ),

              TodayTempContainer(
                seeAllButton: true,
                habits: habitsState,
                listToView: Habitslister(
                  seeAll: false,
                  shrinkWrap: true,
                  canUserScroll: false,
                ),
                nameOfListHeader: 'Today\'s Habits',
                requiredHeight: 400,
                pressSeeAll: () {
                  takeToSeeAllPage(
                    ctxt: context,
                    nameOfListHeader: 'Today\'s Habits',
                    appBarText: 'Your Habits ',
                    showHorizentalCalendar: true,
                    lister: Habitslister(
                      seeAll: true,
                      shrinkWrap: true,
                      canUserScroll: true,
                    ),
                  );
                },
              ),
              const SizedBox(height: 29),
              TodayTempContainer(
                habits: habitsState,
                seeAllButton: true,
                requiredHeight: 0,
                listToView: GoalsCardLister(
                  seeAll: false,
                  shrinkWrap: true,
                  canUserScroll: false,
                ),
                nameOfListHeader: 'Your Weekly Goals',
                pressSeeAll: () {
                  takeToSeeAllPage(
                    ctxt: context,
                    nameOfListHeader: '',
                    appBarText: 'Your Weekly Goals ',
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
      ),
    );
  }

  @override
  void dispose() {
    _animationcontroller.dispose();
    super.dispose();
  }
}
