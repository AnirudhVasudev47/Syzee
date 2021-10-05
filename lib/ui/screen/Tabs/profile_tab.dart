import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syzee/services/auth_service.dart';
import 'package:syzee/ui/screen/Tabs/home_tab.dart';
import 'package:syzee/ui/screen/home_screen.dart';
import 'package:syzee/ui/screen/login_screen.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  Widget profileTile(String image, String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Image.asset(
            image,
            fit: BoxFit.contain,
          ),
          Expanded(
            child: Text(
              name,

            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return firebaseAuth.currentUser == null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LottieBuilder.asset('assets/images/home/lottie/welcome.json'),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Please login for improvised \n user experience',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 24,
                    color: Color(0xff009C95),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff169B93),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 45,
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        : Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  context.read<AuthenticationService>().signOut();
                });
              },
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
                'Sign out',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          );
  }
}
