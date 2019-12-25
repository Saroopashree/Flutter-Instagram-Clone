import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_instagram_clone/screens/feedScreen.dart';
import 'package:flutter_instagram_clone/screens/login_screen.dart';

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
          'profileInmageURL': '',
        });
        Navigator.pushReplacementNamed(context, FeedScreen.id);
      }
    } catch (e) {
      print(e);
    }
  }

  static void login(String email, String password) async {
    _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static void logout(BuildContext context) {
    _auth.signOut();
    Navigator.pushReplacementNamed(context, LoginScreen.id);
  }
}
