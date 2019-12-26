import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = Firestore.instance;

  static void signupUser(
      BuildContext context, String name, String email, String password) async {
    try {
      AuthResult _authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser _signedinUser = _authResult.user;
      if (_signedinUser != null) {
        _firestore.collection("/users").document(_signedinUser.uid).setData({
          'name': name,
          'email': email,
          'profileImageURL': '',
        });
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  static void login(String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }

  static void logout() {
    _auth.signOut();
  }
}
