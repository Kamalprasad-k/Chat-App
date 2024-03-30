import 'package:chat_app/pages/HomePage.dart';
import 'package:chat_app/pages/splashScreen.dart';
import 'package:chat_app/service/auth/SignInOrSignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const SplashScreen();
          }

          if (snapshot.hasData) {
            return HomePage();
          } else {
            return const SignInOrSignUp();
          }
        },
      ),
    );
  }
}
