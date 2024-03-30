import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.message,
    required this.messageTime,
    required this.isCurrentUser,
  }) : super(key: key);

  final String message;
  final Timestamp messageTime; // Use DateTime for accurate time handling
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: isCurrentUser
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isCurrentUser ? 20 : 0),
                      topRight: Radius.circular(isCurrentUser ? 0 : 20),
                      bottomLeft: const Radius.circular(20),
                      bottomRight: const Radius.circular(20),
                    ),
                    color: isCurrentUser
                        ? Colors.blue
                        : Theme.of(context).colorScheme.tertiary,
                  ),
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                DateFormat('hh:mm a').format(messageTime.toDate()),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
