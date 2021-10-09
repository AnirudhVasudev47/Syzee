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

  Widget profileTile(String image, String name, {onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 13,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'VarelaRound',
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Image.asset(
              'assets/images/home/profile_tab/arrow_right.png',
              width: 9,
              height: 9,
            ),
          ],
        ),
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
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Account',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 24,
                  color: Color(0xff009C95),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Text(
                  'James',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Text(
                  'jamesondunn@gmail.com',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      profileTile(
                        'assets/images/home/profile_tab/edit.png',
                        'My Profile',
                      ),
                      profileTile(
                        'assets/images/home/profile_tab/location.png',
                        'My Address',
                      ),
                      profileTile(
                        'assets/images/home/profile_tab/clock.png',
                        'My Orders',
                      ),
                      profileTile(
                        'assets/images/home/profile_tab/payment.png',
                        'Payment details',
                      ),
                      profileTile(
                        'assets/images/home/profile_tab/notification.png',
                        'Sizing Profile',
                      ),
                      profileTile(
                        'assets/images/home/profile_tab/logout.png',
                        'Membership ',
                      ),
                      profileTile(
                        'assets/images/home/profile_tab/logout.png',
                        'Contact us',
                      ),
                      profileTile(
                        'assets/images/home/profile_tab/logout.png',
                        'Log Out',
                        onTap: () {
                          setState(() {
                            context.read<AuthenticationService>().signOut();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const Text(
                              'Terms & conditions',
                              style: TextStyle(
                                fontFamily: 'VarelaRound',
                                fontSize: 17,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Text(
                              'Privacy Policy',
                              style: TextStyle(
                                fontFamily: 'VarelaRound',
                                fontSize: 17,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
