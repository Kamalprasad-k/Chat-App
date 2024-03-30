import 'package:chat_app/pages/settingPage.dart';
import 'package:chat_app/service/auth/authService.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SafeArea(
                child: Container(
                  padding: EdgeInsets.zero,
                  color: Colors.transparent,
                  child: Image.asset(
                    'assets/chatApp.png',
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                ),
                child: ListTile(
                  title: Text(
                    'H O M E',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  leading: const Icon(
                    Icons.home,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                ),
                child: ListTile(
                  title: Text(
                    'S E T T I N G S',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  leading: const Icon(
                    Icons.settings,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(
              25,
            ),
            child: ListTile(
              title: Text(
                'L O G O U T',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              leading: const Icon(
                Icons.logout,
              ),
              onTap: () {
                AuthService().signOut();
              },
            ),
          )
        ],
      ),
    );
  }
}
