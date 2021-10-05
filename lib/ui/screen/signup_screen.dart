import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/services/auth_service.dart';

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
    if (isGood) {
      if (tnc) {
        loadingDialog(context);
        signUpResult = await context.read<AuthenticationService>().signUp(
          email: emailText.text,
          password: passwordText.text,
          context: context,
        );
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
    if (signUpResult == 'failed') {
      displayToast(
        context,
        title: 'Something went wrong',
        desc: 'Please try again later.',
      );
    } else {
      displayToast(context, title: 'Success', desc: 'Successfully signed up');
    }
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
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
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
                        )),
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
                  TextField(
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
                        )),
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
                        vertical: 14.0, horizontal: 25),
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
                                  decoration: TextDecoration.underline),
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
