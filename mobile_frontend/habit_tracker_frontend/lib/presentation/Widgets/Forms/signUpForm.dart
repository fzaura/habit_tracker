import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/Service/NavigationService.dart';
import 'package:habit_tracker/core/utility/SignLogScreenUtil/utilitySignLogWidgets.dart';
import 'package:habit_tracker/core/utility/Validations/validations.dart';
import 'package:habit_tracker/domain/Auth/Entities/AuthUser.dart';
import 'package:habit_tracker/presentation/Auth/Providers/authProvider.dart';
import 'package:habit_tracker/presentation/Widgets/TextFields/Auth/SignLoginField.dart';

class SignUpForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmationController = TextEditingController();
  }

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  // initialized NOW
  late TextEditingController _emailController;
  // initialized NOW
  late TextEditingController _passwordController;
  // initialized NOW
  late TextEditingController _passwordConfirmationController;
  // initialized NOW
  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next is AuthSuccess) {
        // SUCCESS: The user is in memory. Take them home!
        print('Sucess');
        NavigationService.onSignUpPressButton(context);
      } else if (next is AuthFailure) {
        // ERROR: Show the backend error message (e.g., "Email already exists")
        print('Fail Huge LLLLLLLLLLLLLLLLLL');
      }
    });

    return Form(
      key: _formKey,
      child: Column(
        children: [
          SignLoginField(
            text: 'Name',
            controller: _nameController,
            onValidate: (value) {
              String finalValue = Validations.onValidateName(value!);
              if (finalValue == '') {
                return null;
              } else {
                return finalValue;
              }
            },
          ),
          SignLoginField(
            text: 'Email',
            controller: _emailController,
            onValidate: (value) {
              String finalValue = Validations.validateEmail(value!);
              if (finalValue == '') {
                return null;
              } else {
                return finalValue;
              }
            },
          ),

          SignLoginField(
            text: 'Password',
            controller: _passwordController,
            onValidate: (value) {
              String finalValue = Validations.validatePassword(value);
              if (finalValue == '') {
                return null;
              } else {
                return finalValue;
              }
            },
          ),

          SignLoginField(
            text: 'Password Confirmation',
            controller: _passwordConfirmationController,
            onValidate: (value) {
              String finalValue = Validations.validateConfirmPassword(
                value,
                _passwordConfirmationController.text,
              );
              if (finalValue == '') {
                return null;
              } else {
                return finalValue;
              }
            },
          ),
          const SizedBox(height: 24),
          defaultSignLogInButton(
            text: 'Sign Up',
            onPressed: (context) {
              if (_formKey.currentState!.validate()) {
                print(
                  "Email is: ${_emailController.text.trim().toLowerCase()} , ",
                );

                ref
                    .read(authProvider.notifier)
                    .register(
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                      confirmPassword: _passwordConfirmationController.text,
                    );
              } else {
                // ❌ FAIL: Flutter will automatically show the red error text
                print("Form has errors");
              }
            },
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
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }
}
