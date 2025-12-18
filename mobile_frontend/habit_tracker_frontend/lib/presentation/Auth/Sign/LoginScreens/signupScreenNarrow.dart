import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utility/SignLogScreenUtil/utilitySignLogWidgets.dart';
import 'package:habit_tracker/data/Habits/Dummy%20Data/dummyDataSignedUser.dart';
import 'package:habit_tracker/domain/Auth/Entities/user.dart';
import 'package:habit_tracker/presentation/Auth/Sign/LoginScreens/loginScreenNarrow.dart';

class Signupscreen extends StatelessWidget {
  Signupscreen({super.key});

  final TextEditingController _nameController =
      TextEditingController(); // initialized NOW
  final TextEditingController _emailController =
      TextEditingController(); // initialized NOW
  final TextEditingController _passwordController =
      TextEditingController(); // initialized NOW
  final TextEditingController _passwordConfirmationController =
      TextEditingController(); // initialized NOW

  void navToLogScreen(BuildContext ctxt) {
    Navigator.pushReplacement(
      ctxt,
      MaterialPageRoute(builder: (ctxt) => LoginScreen()),
    );
  }

  void onPressSignUp(BuildContext ctxt) {
    dummyUsers.add(
      User(
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
        onIconPressed: navToLogScreen,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SigninInputField('Name', _nameController, context),
            SigninInputField('Email', _emailController, context),

            SigninInputField('Password', _passwordController, context),

            SigninInputField(
              'Password Confirmation',
              _passwordConfirmationController,
              context,
            ),
            const SizedBox(height: 24),
            defaultSignLogInButton(
              text: 'Sign Up',
              onPressed: onPressSignUp,
              ctxt: context,
            ),
            const SizedBox(height: 36),

            defaultSignLogInGoogleButton(
              aboveText: 'Or sign up with : ',
              onPressed: (context) {},
              ctxt: context,
            ),
          ],
        ),
      ),
    );
  }
}
