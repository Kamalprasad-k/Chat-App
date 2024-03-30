import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  // get instance of firestore & Auth
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

//get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _fireStore.collection("Users").snapshots().map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            final users = doc.data();
            return users;
          },
        ).toList();
      },
    );
  }

  //send message
  Future<void> sendMessage(String receiverID, message) async {
    //current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create new messgae
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    //create an chatroom ID for the two users (sort it for the uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    //add new msg to database
    await _fireStore
        .collection('Chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(
          newMessage.toMap(),
        );
  }

  //get message
  Stream<QuerySnapshot> getMessage(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _fireStore
        .collection('Chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy(
          'timestamp',
          descending: false,
        )
        .snapshots();
  }

  //get lastest  message
  // Method to get the latest message for a user
  Future<String> getLatestMessage(String userID) async {
    List<String> sortedUserIDs = [userID, _auth.currentUser!.uid];
    sortedUserIDs.sort();
    String chatRoomID = sortedUserIDs.join('_');

    // Get the message collection reference
    CollectionReference messagesRef = _fireStore
        .collection('Chat_rooms')
        .doc(chatRoomID)
        .collection('messages');

    // Limit the query to 1 document with latest timestamp (descending)
    Query latestMessageQuery =
        messagesRef.orderBy('timestamp', descending: true).limit(1);

    // Try to get the latest message document snapshot
    try {
      QuerySnapshot snapshot = await latestMessageQuery.get();
      if (snapshot.docs.isNotEmpty) {
        // Extract message content from the first document
        return snapshot.docs.first.get('message');
      } else {
        return ""; // No messages found
      }
    } catch (e) {
      // Handle potential errors
      print("Error getting latest message: $e");
      return "";
    }
  }
}
