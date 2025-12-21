import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/core/Service/NavigationService.dart';
import 'package:habit_tracker/core/utility/SignLogScreenUtil/utilitySignLogWidgets.dart';
import 'package:habit_tracker/presentation/Widgets/TextFields/Auth/SignLoginField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  // initialized NOW
  final TextEditingController _passwordController = TextEditingController();
  // initialized NOW

  bool _givenValue = false;

  Row rememberMeForgetPassword() {
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
          child: Form(
            child: Column(
              children: [
                SignLoginField(text: 'Email', controller: _emailController),

                SignLoginField(
                  text: 'Password',
                  controller: _passwordController,
                ),
                const SizedBox(height: 36),

                defaultSignLogInButton(
                  text: 'Log in',
                  onPressed: NavigationService.navToLogScreen,
                  ctxt: context,
                ),
                rememberMeForgetPassword(),
                const SizedBox(height: 36),
                defaultSignLogInGoogleButton(
                  aboveText: 'Or Log in with : ',
                  onPressed: (context) {},
                  ctxt: context,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
