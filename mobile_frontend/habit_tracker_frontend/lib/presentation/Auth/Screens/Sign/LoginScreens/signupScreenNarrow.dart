import 'package:flutter/material.dart';
import 'package:habit_tracker/core/Service/NavigationService.dart';
import 'package:habit_tracker/core/utility/SignLogScreenUtil/utilitySignLogWidgets.dart';

import 'package:habit_tracker/presentation/Widgets/signUpForm.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});


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
        child: SignUpForm()
      ),
    );
  }
}
