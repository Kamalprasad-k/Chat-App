import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
//instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

//signIn
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetch the user's username from Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .get();

      String? username = userDoc.exists ? userDoc['username'] : null;

      // Update the document with the fetched username
      _firestore.collection('Users').doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
          'username': username, // Preserve the existing username
        },
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

//signUp
  Future<UserCredential> signUpWithEmailPassword(
      String username, email, password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      _firestore.collection('Users').doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'username': username,
          'email': email,
        },
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

//signOut
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
