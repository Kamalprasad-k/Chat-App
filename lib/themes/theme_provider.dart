import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat_app/themes/dark_mode.dart';
import 'package:chat_app/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode; // Initial theme set to light

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
    _saveTheme(); // Save the selected theme whenever it changes
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }

  // Save the selected theme to SharedPreferences
  Future<void> _saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  // Load the selected theme from SharedPreferences
  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false; // Default to light if not set
    themeData = isDarkMode ? darkMode : lightMode;
  }

  ThemeProvider() {
    _loadTheme(); // Call to load saved theme on initialization
  }
}
