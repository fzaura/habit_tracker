import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/Config/init_dependencies.dart';
import 'package:habit_tracker/core/Themes/app_theme.dart';
import 'package:habit_tracker/presentation/Habits/BLoC/habit_bloc.dart';
import 'package:habit_tracker/presentation/Habits/Screens/HomeScreens/mainTabScreen.dart';
//import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies(); //1- Boot up GetIt
//Multi Provider so we can add auth provider soo
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => serviceLocator<HabitBloc>())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: AppTheme.lightTheme, home: MainTabScreen());
  }
}
