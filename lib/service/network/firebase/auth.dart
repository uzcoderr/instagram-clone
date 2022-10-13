import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/service/local/shared_pref/auth.dart';
import 'package:instagram/ui/auth/sign_in_page.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User?> signInUser(
      BuildContext context, String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
      final User? firebaseUser = _auth.currentUser;
      return firebaseUser;
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<Map<String, User?>> signUpUser(
      BuildContext context, String name, String email, String password) async {
    Map<String, User?> map = {};
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = authResult.user;
      map.addAll({"SUCCESS":firebaseUser});
    } catch (error) {
      switch (error) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
          map.addAll({"ERROR_EMAIL_ALREADY_IN_USE": null});
          break;
        default:
          map.addAll({"ERROR": null});
      }
    }
    return map;
  }

  static void signOutUser(BuildContext context) {
    _auth.signOut();
    Prefs.removeUserId().then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInPage(),
          ));
    });
  }
}
