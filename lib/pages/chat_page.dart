import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/service/auth/authService.dart';
import 'package:chat_app/service/call/video_call.dart';
import 'package:chat_app/service/call/voice_call.dart';
import 'package:chat_app/service/chat/chatService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.username, required this.receiverID});

  final String username;
  final String receiverID;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController callIdController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if (_formKey.currentState!.validate()) {
      if (messageController.text.isNotEmpty) {
        await _chatService.sendMessage(
            widget.receiverID, messageController.text);
        messageController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.username,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Create/Enter call ID'),
                    content: Form(
                      key: _formKey,
                      child: TextFormField(
                        maxLength: 6,
                        controller: callIdController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a call ID';
                          }
                          if (value.length < 4 || value.length > 6) {
                            return 'Enter 4 to 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          callIdController.clear();
                        },
                        child: const Text(
                          'Cancel',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CallPage(
                                  callID: callIdController.text,
                                  userName: widget.username,
                                ),
                              ),
                            );
                            Navigator.pop(context);
                            callIdController.clear();
                          }
                        },
                        child: const Text(
                          'Call',
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.videocam_rounded,
              color: Colors.blue,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Create/Enter call ID'),
                    content: Form(
                      key: _formKey,
                      child: TextFormField(
                        maxLength: 6,
                        controller: callIdController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a call ID';
                          }
                          if (value.length < 4 || value.length > 6) {
                            return 'Enter 4 to 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          callIdController.clear();
                        },
                        child: const Text(
                          'Cancel',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VoiceCallPage(
                                  callID: callIdController.text,
                                  userName: widget.username,
                                ),
                              ),
                            );
                            Navigator.pop(context);
                            callIdController.clear();
                          }
                        },
                        child: const Text(
                          'Call',
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.call,
              color: Colors.blue,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: buildMessageList(),
          ),
          buildUserInput(),
        ],
      ),
    );
  }

  Widget buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(widget.receiverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Loading...'));
        }
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        children: [
          ChatBubble(
              message: data['message'],
              messageTime: data['timestamp'],
              isCurrentUser: isCurrentUser),
        ],
      ),
    );
  }

  Widget buildUserInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: 'Message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: sendMessage,
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
