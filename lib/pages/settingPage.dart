import 'package:chat_app/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 25,
        ),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dark Mode',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Switch(
              inactiveThumbColor: Colors.blue,
              activeColor: Colors.blue,
              activeTrackColor: Colors.black54,
              value:
                  Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
              onChanged: (value) =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(),
            )
          ],
        ),
      ),
    );
  }
}
