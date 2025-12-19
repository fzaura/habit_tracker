import 'package:flutter/material.dart';
import 'package:habit_tracker/core/Service/NavigationService.dart';
import 'package:habit_tracker/core/utility/SignLogScreenUtil/utilitySignLogWidgets.dart';
import 'package:habit_tracker/data/Habits/Dummy%20Data/dummyDataSignedUser.dart';
import 'package:habit_tracker/domain/Auth/Entities/AuthUser.dart';
import 'package:habit_tracker/presentation/Auth/Screens/Sign/LoginScreens/loginScreenNarrow.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  

  void onPressSignUp(BuildContext ctxt) {
    dummyUsers.add(
      AuthUser(
        id: 4,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        isUserSignedIn: true,
      ),
    );
    navToLogScreen(ctxt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: signLoginBar(
        mainText: 'Sign up',
        buttonText: 'Log in',
        context: context,
        onIconPressed: NavigationService.navToLogScreen,
      ),
      body: SingleChildScrollView(
        child: 
      ),
    );
  }
}
