import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/app/themes.dart';
import 'package:habit_tracker/view(Screens)/HomeScreens/mainTabScreen.dart';
//import 'package:flutter/services.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: mainAppTheme, home: MainTabScreen());
  }
}
