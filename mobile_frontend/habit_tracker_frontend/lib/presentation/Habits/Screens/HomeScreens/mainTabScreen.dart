// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:habit_tracker/presentation/Habits/Screens/HomeScreens/home_Screen.dart';
import 'package:habit_tracker/presentation/Habits/Screens/ProgressScreen/progressScreen.dart';
import 'package:habit_tracker/presentation/Auth/Screens/SettingsScreen/settingsScreen.dart';
import 'package:habit_tracker/presentation/Widgets/BottomNavBar/main_bottom_nav_bar.dart';
import 'package:intl/intl.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});
  

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  String activeScreenName = 'HomeScreen';

  final String formattedDate = DateFormat(
    'EEE d,MMMM,y',
  ).format(DateTime.now());

  void _changeScreen(int index) {
    setState(() {
      activePageIndex = index;
      if (activePageIndex == 0) {
        activeScreenName = 'HomeScreen';
      } else if (activePageIndex == 1) {
        activeScreenName = 'ProgressScreen';
      } else {
        activeScreenName = 'SettingsScreen';
      }
    });
  }

  int activePageIndex = 0;

  @override
  Widget build(BuildContext context) {
   Widget activeScreen = HomeScreen(userName: 'User',);

    if (activePageIndex == 1 || activeScreenName == 'ProgressScreen') {
      activeScreen = ProgressScreen();
    } else if (activePageIndex == 2 || activeScreenName == 'SettingsScreen') {
      activeScreen = SettingsScreen();
    }

    return Scaffold(
      body: activeScreen,
      bottomNavigationBar: HabitaNavbar(currentIndex: 1, onTap: (num){}),
    );
  }
}
