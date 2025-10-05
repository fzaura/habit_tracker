import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:habit_tracker/core/utility/ProgressScreenUtil/utilProgressScreen.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEDED),
      appBar: (AppBar(toolbarHeight: 130,title: Utilprogressscreen.homeScreenWelcomeMessage())),
    );
  }
}
