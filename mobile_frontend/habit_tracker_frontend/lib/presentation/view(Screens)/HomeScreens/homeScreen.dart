import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/domain/Habits/Features/AddNewHabits/addNewHabit.dart';
import 'package:habit_tracker/presentation/Widgets/Cards/HomeScreenCards/HomeScreenWelcomeCard.dart';
import 'package:habit_tracker/presentation/Widgets/Title/HomeScreenWelcomeMessage.dart';
import 'package:habit_tracker/presentation/Widgets/Container/HomeScreen/todayTempContainer.dart';
import 'package:habit_tracker/presentation/Widgets/Lists/habitsLister.dart';
import 'package:habit_tracker/presentation/Widgets/Lists/goalsCardLister.dart';
import 'package:habit_tracker/presentation/Providers/habitsStateNotifier.dart';
import 'package:habit_tracker/presentation/view(Screens)/SeeAllTemp/seeAllTodayHabits.dart';
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
    showDialog(context: context, builder: (context) => Addnewhabit());
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
        title: HomeScreenWelcomeMessage(
          formattedDate: formattedDate,

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
                habits: habitsList,
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
                habits: habitsList,
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
