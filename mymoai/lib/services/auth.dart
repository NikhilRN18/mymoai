import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mymoai/models/user.dart';
import 'package:mymoai/services/database_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users? _userFromFirebaseUser(User? user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  Stream<Users?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user));
  }

  Future signInAnon() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      final user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future signInEmail(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future registerEmail(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = result.user;

      await DatabaseUser(uid: user?.uid).updateUserData("Unknown", "", 1, 1, 2000, email, 0, 'Cupertino', 'CA', 'United States', '', '', 0, 0, 600);
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }

  }

  Future<String> currentUser() async {
    return _auth.currentUser!.uid;
  }

}