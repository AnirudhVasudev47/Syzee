import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/ui/screen/landing_screen.dart';
import 'package:http/http.dart' as http;

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

  Future<String> checkUser (String email, String phone) async {
    Uri checkUri = Uri.parse('${AssetConstants.mockApiLink}/user/checkUser');

    Map<String, dynamic> checkMap = {};
    checkMap['email'] = email;
    checkMap['phone'] = phone;

    var response = await http.post(checkUri, body: checkMap);
    if (jsonDecode(response.body)['data'] == 'Already registered') {
      return 'stop';
    } else {
      return 'proceed';
    }
  }

  Future<String> logInUser(String email, String password) async {
    Uri signInUri = Uri.parse('${AssetConstants.mockApiLink}/user/signin');

    Map<String, dynamic> loginData = {};
    loginData['email'] = email;
    loginData['password'] = password;

    var response = await http.post(signInUri, body: loginData);
    var resBody = jsonDecode(response.body)['data'];
    print(jsonDecode(response.body));
    if(response.statusCode == 200) {
      if (resBody == 'Not registered') {
        return 'not-reg';
      } else if (resBody == 'Wrong password'){
        return 'wrong-pass';
      } else {
        return resBody.toString();
      }
    } else {
      return 'failed';
    }
  }

  Future<String> phoneAuth(String phoneNumber, BuildContext context) async {
    String verId = '';
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(minutes: 2),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          displayToast(
            context,
            title: 'Phone number automatically verified',
            desc: 'signed in successfully',
          );
          verId = 'success';
        },
        verificationFailed: (FirebaseAuthException authException) {
          displayToast(
            context,
            title:
                'Phone number verification failed. Code: ${authException.code}',
            desc: ' Message: ${authException.message}',
          );
          // verId = 'failed';
        },
        codeSent: (String verificationId, [int? forceResendingToken]) {
          verId = verificationId;
          displayToast(
            context,
            title: 'OTP sent successfully',
            desc: 'Please check your phone for the verification code.',
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verId = verificationId;
        },
      );
      return verId;
    } catch (e) {
      displayToast(
        context,
        title: "Failed to Verify Phone Number: ",
        desc: e.toString(),
      );
      return 'failed';
    }
  }

  Future<String> signInWithPhoneNumber(String verId, String otp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verId,
        smsCode: otp,
      );

       await _firebaseAuth.signInWithCredential(credential);

      return 'success';
    } catch (e) {
      print(e);
      return 'failed';
    }
  }



}
