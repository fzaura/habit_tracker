import 'package:flutter/material.dart';
import 'package:habit_tracker/presentation/Widgets/AppBar/main_app_bar.dart';
import 'package:habit_tracker/presentation/Widgets/Container/HomeScreen/section_header.dart';
import 'package:habit_tracker/presentation/Widgets/Lists/goalsCardLister.dart';
import 'package:habit_tracker/presentation/Widgets/Lists/to_do_card_Lister.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  Widget mainHomeBody() {
    return Column(
      children: [
        SizedBox(height: 10),
        SectionHeader(title: 'Goals', onAddPressed: () {}),
        SizedBox(
          height: 265,
          width: 440,
          child: GoalsCardLister(
            seeAll: true,
            shrinkWrap: true,
            canUserScroll: true,
          ),
        ),
        SizedBox(height: 10),
        SectionHeader(title: 'Todo', onAddPressed: () {}, viewDetails: true,),
        SizedBox(
          height: 280,
          width: 440,
          child: ToDoLister(
            seeAll: true,
            shrinkWrap: true,
            canUserScroll: true,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: MainAppBar(
        userName: "Aser",
        goalDescription: "Goal Task Is Drinking 2L\nOf Water",
        date: "MON / 3 / 20",
      ),
      body: mainHomeBody(),
      
    );
  }
}
