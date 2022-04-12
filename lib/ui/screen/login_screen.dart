import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/services/auth_service.dart';
import 'package:syzee/ui/screen/landing_screen.dart';
import 'package:syzee/ui/screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailText = TextEditingController();
  TextEditingController passText = TextEditingController();
  TextEditingController otpText = TextEditingController();
  String signInResult = '';

  String phone = '';

  bool isTextVisible = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailText.dispose();
    passText.dispose();
    otpText.dispose();
  }

  bool checkFields() {
    if (emailText.text.isEmpty || passText.text.isEmpty) {
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
    } else {
      return true;
    }
  }

  bool isEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  handleEmailLogin() async {
    bool isGood = checkFields();
    if (isGood) {
      loadingDialog(context, asset: 'assets/images/home/lottie/loading.json');
      signInResult = await context.read<AuthenticationService>().logInUser(
            emailText.text,
            passText.text,
          );
      print('result: ' + signInResult);
    } else {
      return;
    }
    if (signInResult == 'failed') {
      displayToast(
        context,
        title: 'Something went wrong',
        desc: 'Please try again later.',
      );
    } else if (signInResult == 'not-reg') {
      displayToast(
        context,
        title: 'User not registered',
        desc: 'Sign up to continue',
      );
    } else if (signInResult == 'wrong-pass') {
      displayToast(
        context,
        title: 'Wrong password',
        desc: 'Please enter the correct password',
      );
    } else {
      setState(() {
        phone = signInResult;
      });
      continueWithVerification();
    }
  }

  continueWithVerification() async {
    print('phone: '+phone);
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
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
            const SizedBox(
              height: 55,
            ),
            const Text(
              'Enter the OTP sent',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 25,
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter the OTP sent',
                  hintStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                  ),
                ),
                keyboardType: TextInputType.phone,
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
              padding: const EdgeInsets.symmetric(vertical: 70),
              child: Image.asset(
                AssetConstants.blackLogo,
                height: 69,
                width: 209,
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xffe5e3e3),
                          offset: Offset(0.5, 0.5),
                          blurRadius: 10,
                          spreadRadius: 1)
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 77, left: 23),
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 30,
                          color: Color(0xff009C95),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 45.0,
                        left: 25,
                        right: 25,
                      ),
                      child: TextField(
                        controller: emailText,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
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
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 25.0,
                        left: 25,
                        right: 25,
                      ),
                      child: TextField(
                        controller: passText,
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
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () async {
                          if (isEmail(emailText.text)) {
                            String result = await context
                                .read<AuthenticationService>()
                                .resetPassword(emailText.text);
                            if (result == 'sent') {
                              displayToast(context,
                                  title: 'Email sent',
                                  desc:
                                      'Please reset your password from the link sent',
                                  type: 'success');
                            } else {
                              displayToast(
                                context,
                                title: 'Something went wrong',
                                desc: 'Please try again later',
                              );
                            }
                          } else {
                            displayToast(
                              context,
                              title: 'Invalid Email',
                              desc: 'Please check the entered e-mail again',
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 25,
                          ),
                          child: const Text(
                            'Forgot Password?',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: handleEmailLogin,
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
                          'Login',
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
                          vertical: 14.0, horizontal: 25),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text.rich(
                          TextSpan(
                            text: 'Don\'t have an account?',
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 17,
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: ' Sign up',
                                style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 17,
                                    color: Color(0xff0346FF),
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpScreen(),
                                          ),
                                        )
                                      },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
