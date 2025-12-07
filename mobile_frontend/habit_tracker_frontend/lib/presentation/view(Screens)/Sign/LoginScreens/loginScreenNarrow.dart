import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/core/utility/SignLogScreenUtil/utilitySignLogWidgets.dart';
import 'package:habit_tracker/data/Dummy%20Data/dummyDataSignedUser.dart';
import 'package:habit_tracker/domain/Entities/user.dart';
import 'package:habit_tracker/presentation/view(Screens)/HomeScreens/mainTabScreen.dart';
import 'package:habit_tracker/presentation/view(Screens)/Sign/LoginScreens/signupScreenNarrow.dart';
import 'package:habit_tracker/app/globalData.dart';

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
  bool checkLoginInfo() {
    if (dummyUsers.any((user) => user.email == _emailController.text) &&
        (dummyUsers.any((user) => user.password == _passwordController.text))) {
      return true;
    } else {
      return false;
    }
  }

  void findUserbyEmailandPass(String password, String email) {
    GlobalData.currentUser = User(
      id: 0,
      email: '',
      password: '',
      name: '',
      isUserSignedIn: false,
    );
    for (User user in dummyUsers) {
      if (user.password == password && user.email == email) {
        GlobalData.currentUser = user;
      }
    }
  }

  void onLoginPress(BuildContext context) {
    if (checkLoginInfo()) {
      findUserbyEmailandPass(_passwordController.text, _emailController.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainTabScreen()),
      );
    } else {
      showErrorDialog(
        ctxt: context,
        mainTitile: 'Wrong Inputs',
        contentOfTitle:
            'The password or the email that you entered wasn\'t valid ',
      );
    }
  }

  void onSignUpPress(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Signupscreen()),
    );
  }

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
        onIconPressed: onSignUpPress,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width > 500
                ? 400
                : double.infinity,
          ),
          child: Column(
            children: [
              SigninInputField('Email', _emailController, context),

              SigninInputField('Password', _passwordController, context),
              const SizedBox(height: 36),

              defaultSignLogInButton(
                text: 'Log in',
                onPressed: onLoginPress,
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
    );
  }
}
