import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:syzee/ui/screen/landing_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameText = TextEditingController();
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController repeatPassText = TextEditingController();
  TextEditingController phoneText = TextEditingController();
  TextEditingController otpText = TextEditingController();

  String verId = '';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String co = '974';

  bool isTextVisible = false;
  bool tnc = false;
  String name = '';
  String email = '';
  String password = '';
  String phoneNumber = '';

  String? emailError;
  String? passError;
  String? emailFinalError;
  String? passFinalError;
  String signUpResult = 'failed';
  String? passResetResult;


  @override
  void dispose() {
    super.dispose();
    nameText.dispose();
    emailText.dispose();
    passwordText.dispose();
    repeatPassText.dispose();
    phoneText.dispose();
    otpText.dispose();
  }

  bool checkFields() {
    if (emailText.text.isEmpty ||
        passwordText.text.isEmpty ||
        repeatPassText.text.isEmpty ||
        nameText.text.isEmpty ||
        phoneText.text.isEmpty) {
      displayToast(
        context,
        title: 'Fields empty',
        desc: 'Please fill all the fields',
      );
      return false;
    } else if (!isEmail(emailText.text.toString())) {
      displayToast(
        context,
        title: 'Invalid Email',
        desc: 'Email entered is wrong please check again',
      );
      return false;
    } else if (passwordText.text.toString() != repeatPassText.text.toString()) {
      displayToast(
        context,
        title: 'Password mismatch',
        desc: 'Password does not match the repeated password',
      );
      return false;
    } else if (phoneText.text.toString().length != 10) {
      displayToast(
        context,
        title: 'Invalid phone number',
        desc: 'Please enter a valid phone number',
      );
      return false;
    } else {
      return true;
    }
  }

  bool isEmail(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  handleEmailSignUp() async {
    bool isGood = checkFields();
    String checkRes = '';
    if (isGood) {
      if (tnc) {
        loadingDialog(context, asset: 'assets/images/home/lottie/loading.json');
        checkRes = await context
            .read<AuthenticationService>()
            .checkUser(emailText.text, phoneText.text);
      } else {
        displayToast(
          context,
          title: 'Accept T&C',
          desc: 'Please accept the Terms and Conditions.',
        );
        return;
      }
    } else {
      return;
    }
    if (checkRes == 'stop') {
      Navigator.pop(context);
      return displayToast(
        context,
        title: 'Email is registered.',
        desc:
            'Entered email is already registered. Please sign in to continue.',
      );
    } else {
      continueWithVerification();
    }
  }

  continueWithVerification() async {
    String code = '+$co';
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: '$code${phoneText.text}',
        timeout: const Duration(minutes: 2),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          _firebaseAuth
              .signInWithCredential(phoneAuthCredential)
              .whenComplete(verSuccess);
        },
        verificationFailed: (FirebaseAuthException authException) {
          displayToast(
            context,
            title:
                'Phone number verification failed. Code: ${authException.code}',
            desc: ' Message: ${authException.message}',
          );
          verFailed();
        },
        codeSent: (String verificationId, [int? forceResendingToken]) {
          showOtpDialog(verificationId);
          displayToast(context,
              title: 'OTP sent successfully',
              desc: 'Please check your phone for the verification code.',
              type: 'success');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          showOtpDialog(verificationId);
        },
      );
    } catch (e) {
      displayToast(
        context,
        title: "Failed to Verify Phone Number: ",
        desc: e.toString(),
      );
      return 'failed';
    }
  }

  verFailed() {
    displayToast(
      context,
      title: 'Something went wrong',
      desc: 'Please try again later.',
      type: 'danger',
    );
  }

  verSuccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> userData = {};
    userData['name'] = nameText.text;
    userData['phone'] = phoneText.text;
    userData['email'] = emailText.text;
    userData['code'] = '+$co';
    userData['password'] = passwordText.text;

    Uri createUri = Uri.parse('${AssetConstants.mockApiLink}/user/signup');
    var response = await http.post(createUri, body: userData);
    if (jsonDecode(response.body)['data'] == 'Success') {
      prefs.setString('userMail', emailText.text);
      displayToast(
        context,
        title: 'Phone number automatically verified',
        desc: 'signed in successfully',
        type: 'success',
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LandingPage(),
        ),
            (route) => false,
      );
    }
  }

  showOtpDialog(verId) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Enter the OTP sent',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 25,
              ),
              child: TextField(
                decoration:
                    const InputDecoration(hintText: 'Enter the OTP sent',
                      hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                      ),),
                autofocus: true,
                controller: otpText,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final AuthCredential credential = PhoneAuthProvider.credential(
                          verificationId: verId,
                          smsCode: otpText.text,
                        );

                        await _firebaseAuth.signInWithCredential(credential);

                        verSuccess();
                      } catch (e) {
                        print(e);
                        verFailed();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff169B93),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 25,
                      ),
                    ),
                    child: const Text(
                      'Submit OTP',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      continueWithVerification();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff169B93),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 25,
                      ),
                    ),
                    child: const Text(
                      'Resend OTP',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 65.0, bottom: 50),
              child: Image.asset(
                AssetConstants.blackLogo,
                height: 42,
                width: 127,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Register',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 30,
                    color: Color(0xff009C95)),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                    ),
                  ),
                  TextField(
                    controller: nameText,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                    ),
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff169B93),
                          width: 1,
                        ),
                      ),
                      hintText: 'Enter your name',
                      hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Email',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                  ),
                  TextField(
                    controller: emailText,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff169B93),
                            width: 1,
                          ),
                        ),
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                        )),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                  ),
                  TextField(
                    controller: passwordText,
                    obscureText: !isTextVisible,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isTextVisible = !isTextVisible;
                          });
                        },
                        icon: Icon(
                          isTextVisible
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff169B93),
                          width: 1,
                        ),
                      ),
                      hintText: 'Enter new password',
                      hintStyle: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Re enter Password',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                  ),
                  TextField(
                    controller: repeatPassText,
                    obscureText: !isTextVisible,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isTextVisible = !isTextVisible;
                          });
                        },
                        icon: Icon(
                          isTextVisible
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff169B93),
                          width: 1,
                        ),
                      ),
                      hintText: 'Enter new password',
                      hintStyle: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Phone number',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: true,
                            // optional. Shows phone code before the country name.
                            onSelect: (Country country) {
                              setState(() {
                                co = country.phoneCode;
                              });
                            },
                          );
                        },
                        child: Text(
                          '+$co',
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextField(
                          controller: phoneText,
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                          ),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff169B93),
                                width: 1,
                              ),
                            ),
                            hintText: 'Enter your phone number',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Checkbox(
                          value: tnc,
                          onChanged: (val) {
                            setState(() {
                              tnc = !tnc;
                            });
                          },
                        ),
                        const Text(
                          'Terms and conditions',
                          style:
                          TextStyle(fontFamily: 'Montserrat', fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: handleEmailSignUp,
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff169B93),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 72,
                        ),
                      ),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14.0,
                      horizontal: 25,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                          text: 'Already have an account?',
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 17,
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                              text: ' Sign in',
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 17,
                                color: Color(0xff0346FF),
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => {Navigator.of(context).pop()},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
 showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          backgroundColor: Colors.black,
          context: context,
          isScrollControlled: true,
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    'Enter the OTP sent',
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 25,
                  ),
                  child: TextField(
                    decoration:
                        const InputDecoration(hintText: 'Enter the OTP sent'),
                    autofocus: true,
                    controller: otpText,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff169B93),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 25,
                          ),
                        ),
                        child: const Text(
                          'Submit OTP',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff169B93),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 25,
                          ),
                        ),
                        child: const Text(
                          'Resend OTP',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
 */