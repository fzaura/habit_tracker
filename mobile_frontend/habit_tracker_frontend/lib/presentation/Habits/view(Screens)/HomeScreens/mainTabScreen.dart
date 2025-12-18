// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:habit_tracker/presentation/Habits/view(Screens)/HomeScreens/homeScreen.dart';
import 'package:habit_tracker/presentation/Habits/view(Screens)/ProgressScreen/progressScreen.dart';
import 'package:habit_tracker/presentation/Auth/SettingsScreen/settingsScreen.dart';
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
    Widget activeScreen = Homescreen();

    if (activePageIndex == 1 || activeScreenName == 'ProgressScreen') {
      activeScreen = ProgressScreen();
    } else if (activePageIndex == 2 || activeScreenName == 'SettingsScreen') {
      activeScreen = SettingsScreen();
    }

    return Scaffold(
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _changeScreen,
        currentIndex: activePageIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined,size: 33,),
            label: 'Home',
          
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add_chart_outlined,size: 33,),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined,size: 33,),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
