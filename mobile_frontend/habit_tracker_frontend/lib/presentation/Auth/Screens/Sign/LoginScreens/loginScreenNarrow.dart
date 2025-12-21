import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/core/Service/NavigationService.dart';
import 'package:habit_tracker/core/utility/SignLogScreenUtil/utilitySignLogWidgets.dart';
import 'package:habit_tracker/presentation/Widgets/Forms/loginForm.dart';
import 'package:habit_tracker/presentation/Widgets/TextFields/Auth/SignLoginField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: signLoginBar(
        context: context,
        mainText: 'Log in',
        buttonText: 'Sign up',
        onIconPressed: NavigationService.onSignUpPress,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width > 500
                ? 400
                : double.infinity,
          ),
          child: LoginForm()
        ),
      ),
    );
  }
}
