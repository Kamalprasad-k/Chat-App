import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chat_app/components/myBotton.dart';
import 'package:chat_app/components/passField.dart';
import 'package:chat_app/components/email_textfield.dart';
import 'package:chat_app/service/auth/authService.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  final void Function() onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final username = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  File? selectedPicture;

  void register(BuildContext context) async {
    final authService = AuthService();
    if (confirmPassController.text == passController.text) {
      try {
        await authService.signUpWithEmailPassword(
            username.text, emailController.text, passController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registration successful!"),
          ),
        );
      } catch (e) {
        String errorMessage = "An error occurred. Please try again.";
        if (e.toString().contains("email-already-in-use")) {
          errorMessage = "This email is already in use.";
        } else if (e.toString().contains("weak-password")) {
          errorMessage = "Password is too weak.";
        } else if (e.toString().contains("invalid-email")) {
          errorMessage = "Invalid email address.";
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords don't match."),
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
                    "Let's create an account for you!",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: username,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
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
                    height: 12,
                  ),
                  PasswordTextfield(
                    controller: confirmPassController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyButton(
                    onTap: () => register(context),
                    text: 'Sign Up',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a member?',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Login now',
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
