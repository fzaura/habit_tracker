import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utility/SignLogScreenUtil/utilitySignLogWidgets.dart';
import 'package:habit_tracker/presentation/Widgets/TextFields/Auth/SignLoginField.dart';

class SignUpForm extends StatelessWidget {
final _formKey=GlobalKey<FormState>();

final TextEditingController _nameController =
      TextEditingController(); // initialized NOW
  final TextEditingController _emailController =
      TextEditingController(); // initialized NOW
  final TextEditingController _passwordController =
      TextEditingController(); // initialized NOW
  final TextEditingController _passwordConfirmationController =
      TextEditingController(); // initialized NOW

  

  @override
  Widget build(BuildContext context) {
    return Form(key: _formKey,child: Column(
          children: [
            SignLoginField(text: 'Name',controller: _nameController ),
            SignLoginField(text: 'Email',controller:  _emailController),
        
            SignLoginField(text: 'Password',controller: _passwordController),
        
            SignLoginField(
            text:   'Password Confirmation',
            controller:   _passwordConfirmationController,
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
        ),);
  }
}