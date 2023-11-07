import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // sign out user
  Future<bool> signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  Future<String> errHandler(msg) async {
    try {
      if (msg == "invalid-phone-number") {
        msg = "Given phone number is invalid.";
      } else if (msg == "phone-number-already-exists") {
        msg = "Given phone number already exist in our Database.";
      } else if (msg == "invalid-verification-code") {
        msg = "Wrong OTP please try again.";
      } else if (msg == "invalid-email") {
        msg = "The email is invalid.";
      }
      return msg;
    } catch (e) {
      return "error";
    }
  }

  Future<String> loginAdmin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<String> registerAdmin(
      {required String email,
      required String password,
      required String displayName,
      required BuildContext context}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await result.user?.updateDisplayName(displayName);

      return 'Success';
    } on FirebaseAuthException catch (e) {
      return errHandler(e.code);
    }
  }
}
