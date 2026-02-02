import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/Themes/themes.dart';
import 'package:habit_tracker/core/Themes/app_theme.dart';
import 'package:habit_tracker/core/utility/SignLogScreenUtil/utilitySignLogWidgets.dart';
import 'package:habit_tracker/core/utility/Validations/validations.dart';
import 'package:habit_tracker/presentation/Auth/bloc/auth_bloc_bloc.dart';
import 'package:habit_tracker/presentation/Habits/Screens/HomeScreens/home_screen.dart';
import 'package:habit_tracker/presentation/Widgets/GlobalStateBuilder/auth_state_builder.dart';
import 'package:habit_tracker/presentation/Widgets/TextFields/Auth/SignLoginField.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});
  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _emailController;
  // initialized NOW
  late TextEditingController _passwordController;
  // initialized NOW

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  Widget initialState() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
          const SizedBox(height: 36),

          defaultSignLogInButton(
            text: 'Log in',
            onPressed: (context) {
              print('Key is Pressed');
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<AuthBlocBloc>(context).add(
                  LoginEvent(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  ),
                );
              } else {
                print("Form has errors");
              }
            },
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
    //Listen to The Button's Result

    return BlocConsumer<AuthBlocBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is AuthBlocSuccess) {
          final snackBar = SnackBar(
            content: Text('Logged in Successfully!'),
            backgroundColor: AppTheme.lightTheme.primaryColor,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(userName: state.user.username),
            ),
          );
        }

        if (state is AuthBlocFailure) {
          final snackBar = SnackBar(
            content: Text(state.message),
            backgroundColor: AppTheme.lightTheme.primaryColor,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return AuthStateBuilder(state: state, initialWidget: initialState());
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
