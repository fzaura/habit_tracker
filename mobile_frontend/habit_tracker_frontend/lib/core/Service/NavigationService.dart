import 'package:flutter/material.dart';
import 'package:habit_tracker/presentation/Auth/Screens/Sign/LoginScreens/loginScreenNarrow.dart';
import 'package:habit_tracker/presentation/Auth/Screens/Sign/LoginScreens/signupScreenNarrow.dart';
import 'package:habit_tracker/presentation/Auth/bloc/auth_bloc_bloc.dart';
import 'package:habit_tracker/presentation/Habits/Screens/HomeScreens/mainTabScreen.dart';
import 'package:habit_tracker/presentation/Habits/Screens/HomeScreens/sucessScreenUtil.dart';
import 'package:habit_tracker/presentation/Habits/Screens/SeeAllTemp/seeAllTodayHabits.dart';

class NavigationService {
  static void takeToSeeAllPage({
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

  static void navToLogScreen(BuildContext ctxt) {
    Navigator.pushReplacement(
      ctxt,
      MaterialPageRoute(builder: (ctxt) => LoginScreen()),
    );
  }
  
 static void onSignUpPress(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
  }

  static void onSignUpPressButton(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainTabScreen()),
    );
  }

static void onLoginInPressButton(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainTabScreen()),
    );
  }

// Inside your NavigationService class
static void handleAuthState(BuildContext context, AuthBlocState state) {
  if (state is AuthBlocState) {
    onSignUpPressButton(context);
  } else if (state is AuthBlocFailure) {
    print('Failed AT UI');
  }
}

static void navToSucessScreen(BuildContext context, AuthBlocState state) {
 Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SucessScreenUtil()),
    );
}


}
