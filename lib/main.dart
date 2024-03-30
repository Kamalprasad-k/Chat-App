import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/service/auth/AuthGate.dart';
import 'package:chat_app/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
// Other imports...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Chat App',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData,
          home: const AuthGate(), // Replace with your main app widget
        );
      },
    );
  }
}
