import 'package:chat_app/components/drawer.dart';
import 'package:chat_app/service/auth/authService.dart';
import 'package:chat_app/service/chat/chatService.dart';
import 'package:flutter/material.dart';

import '../components/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //chat&auth services
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          children: [
            Text(
              'Chat',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              'App',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.blue),
            ),
          ],
        ),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: buildUserList(),
    );
  }

  Widget buildUserList() {
    return StreamBuilder(
      stream: chatService.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>(
                (userData) => buildUserListItem(userData, context),
              )
              .toList(),
        );
      },
    );
  }

  Widget buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != authService.getCurrentUser()!.email) {
      // Call getLatestMessage asynchronously and handle the future
      return FutureBuilder<String>(
        future: chatService.getLatestMessage(userData['uid']),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error getting latest message: ${snapshot.error}");
            return const Text("Error"); // Handle error gracefully
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }

          String latestMessage =
              snapshot.data ?? ""; // Use empty string as default

          return UserTile(
            username: userData['username'],
            message: latestMessage.isEmpty ? "..." : latestMessage,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    username: userData['username'],
                    receiverID: userData['uid'],
                  ),
                ),
              );
            },
          );
        },
      );
    } else {
      return Container();
    }
  }
}
