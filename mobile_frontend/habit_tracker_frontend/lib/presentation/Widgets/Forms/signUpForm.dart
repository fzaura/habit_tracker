import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/Service/NavigationService.dart';
import 'package:habit_tracker/core/utility/SignLogScreenUtil/utilitySignLogWidgets.dart';
import 'package:habit_tracker/domain/Auth/Entities/AuthUser.dart';
import 'package:habit_tracker/presentation/Auth/Providers/authProvider.dart';
import 'package:habit_tracker/presentation/Auth/State/authState.dart';
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

  String _onValidateName(String? value) {
    if (value == null ||
        value.isEmpty ||
        value.trim().length == 1 ||
        value.trim().length > 50) {
      return 'The Name Should be between 2 to 50 characters'; //An Error In Input Has occured
    } else {
      return ''; //No Error Has Occured
    }
  }

  String _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // Trusted Measures:
    // Min 8 characters, at least 1 Uppercase, 1 Lowercase, 1 Number and 1 Special Character
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );

    if (!passwordRegex.hasMatch(value)) {
      return 'Password must be 8+ characters with upper, lower, number & special char';
    }

    return ''; // Success
  }

  String _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // The "Standard" Email Regex
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return ''; // Logic passed
  }

  String _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    // Cross-check with the main password controller
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }

    return ''; // Success
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
        print('Sucess') ;
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
              String finalValue = _onValidateName(value!);
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
              String finalValue = _validateEmail(value!);
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
              String finalValue = _validatePassword(value);
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
              String finalValue = _validateConfirmPassword(value);
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
