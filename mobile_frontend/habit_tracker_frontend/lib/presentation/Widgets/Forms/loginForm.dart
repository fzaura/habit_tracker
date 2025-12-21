import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/core/Service/NavigationService.dart';
import 'package:habit_tracker/core/utility/SignLogScreenUtil/utilitySignLogWidgets.dart';
import 'package:habit_tracker/presentation/Widgets/TextFields/Auth/SignLoginField.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  // initialized NOW
  final TextEditingController _passwordController = TextEditingController();
  // initialized NOW

  bool _givenValue = false;

  Row _rememberMeForgetPassword() {
    return Row(
      mainAxisSize: MainAxisSize.min,

      children: [
        Checkbox(
          value: _givenValue,
          onChanged: (isTrue) {
            setState(() {
              _givenValue = isTrue ?? false;
            });
          },
        ),
        Text(' Remember me '),
        const SizedBox(width: 64),
        TextButton(
          onPressed: () {},
          child: Text(
            'Forgot Password?',
            style: GoogleFonts.nunito(color: mainAppTheme.colorScheme.primary),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SignLoginField(text: 'Email', controller: _emailController),

          SignLoginField(text: 'Password', controller: _passwordController),
          const SizedBox(height: 36),

          defaultSignLogInButton(
            text: 'Log in',
            onPressed: NavigationService.navToLogScreen,
            ctxt: context,
          ),
          _rememberMeForgetPassword(),
          const SizedBox(height: 36),
          defaultSignLogInGoogleButton(
            aboveText: 'Or Log in with : ',
            onPressed: (context) {},
            ctxt: context,
          ),
        ],
      ),
    );
  }
}
