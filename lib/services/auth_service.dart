import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/ui/screen/landing_screen.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    try {
      await FirebaseAuth.instance.signInWithCredential(credential).whenComplete(
        () async {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LandingPage(),
            ),
            (route) => false,
          );
        },
      );
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return "success";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> signUp(
      {required email,
      required String password,
      required BuildContext context}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .whenComplete(() async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LandingPage(),
          ),
          (route) => false,
        );
      }).catchError((e) {
        displayToast(
          context,
          title: 'Something went wrong',
          desc: 'Please try again later.',
        );
      });
      return "success";
    } on FirebaseAuthException catch (e) {
      return 'failed' + e.toString();
    }
  }

  Future<String> signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      return 'success';
    } catch (e) {
      return 'failed' + e.toString();
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return 'sent';
    } on Exception catch (e) {
      return 'failed' + e.toString();
    }
  }
}
