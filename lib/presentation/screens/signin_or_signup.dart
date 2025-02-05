import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minly_media_mobile/business-logic/bloc/auth/user_bloc.dart';
import 'package:minly_media_mobile/presentation/screens/login.dart';
import 'package:minly_media_mobile/presentation/screens/signup.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  // toggle between login and register page
  void togglePages() {
    BlocProvider.of<UserBloc>(context).add(UserInitialEvent());

    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return SignupPage(
        onTap: togglePages,
      );
    }
  }
}
