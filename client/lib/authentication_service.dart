import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String pseudo,
    required String phone,
  }) async {
    bool signedUp = false;
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      String userId = (await FirebaseAuth.instance.currentUser!).uid;

      DocumentReference<Map<String, dynamic>> users =
          FirebaseFirestore.instance.collection('users').doc(userId);
      users.set({
        'userID': userId,
        'email': email,
        'password': password,
        'pseudo': pseudo,
        'phone number': phone,
        'description': "",
        'friendsList': [],
        'travelList': []
      });
      signedUp = true;
      return signedUp;
    } on FirebaseAuthException catch (e) {
      return signedUp;
    }
  }
}
