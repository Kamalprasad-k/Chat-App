import 'package:chat_app/pages/loginpage.dart';
import 'package:chat_app/pages/registerPage.dart';
import 'package:flutter/material.dart';

class SignInOrSignUp extends StatefulWidget {
  const SignInOrSignUp({super.key});

  @override
  State<SignInOrSignUp> createState() => _SignInOrSignUpState();
}

class _SignInOrSignUpState extends State<SignInOrSignUp> {
  bool isSignIn = true;

  void toggleScreen() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSignIn) {
      return LoginPage(onTap: toggleScreen);
    } else {
      return RegisterPage(onTap: toggleScreen);
    }
  }
}
