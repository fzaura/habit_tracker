import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/Config/init_dependencies.dart';

import 'package:habit_tracker/core/Service/NavigationService.dart';
import 'package:habit_tracker/core/utility/SignLogScreenUtil/utilitySignLogWidgets.dart';
import 'package:habit_tracker/presentation/Auth/bloc/auth_bloc_bloc.dart';
import 'package:habit_tracker/presentation/Widgets/Forms/loginForm.dart';

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
          child: LoginForm(),
        ),
      ),
    );
  }
}
