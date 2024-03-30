import 'package:flutter/material.dart';
import 'package:chat_app/components/myBotton.dart';
import 'package:chat_app/components/passField.dart';
import 'package:chat_app/components/email_textfield.dart';
import 'package:chat_app/service/auth/authService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  final void Function() onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
   

  void login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
          emailController.text, passController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login successful!"),
        ),
      );
    } catch (e) {
      String errorMessage = "An error occurred. Please try again.";
      if (e.toString().contains("user-not-found")) {
        errorMessage = "User not found. Please check your email.";
      } else if (e.toString().contains("wrong-password")) {
        errorMessage = "Invalid password. Please try again.";
      } else if (e.toString().contains("invalid-email")) {
        errorMessage = "Invalid email address.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/chatApp.png',
                    height: 180,
                    width: 180,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Welcome back!",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  EmailTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  PasswordTextfield(
                    controller: passController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyButton(
                    onTap: () => login(context),
                    text: 'Login',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Sign Up now',
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
