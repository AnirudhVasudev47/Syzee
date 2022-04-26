import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syzee/global/color.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/theme.dart';
import 'package:syzee/services/auth_service.dart';
import 'package:syzee/ui/screen/landing_screen.dart';
import 'package:syzee/ui/screen/onboarding_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..maxConnectionsPerHost = 30;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: CustomTheme.lightTheme,
          darkTheme: CustomTheme.darkTheme,
          themeMode: currentTheme.currentTheme,
          home: const AuthenticationWrapper(),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen(
      {Key? key, required this.nextScreen, required this.useLottie})
      : super(key: key);

  final Widget nextScreen;
  final bool useLottie;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => widget.nextScreen,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff009C95),
            Color(0xff0B4E4A),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: ThemeColors.transparent,
        body: Container(
          padding: EdgeInsets.all(
            ScreenUtil().setHeight(62),
          ),
          alignment: Alignment.center,
          child: Image.asset(AssetConstants.logo),
        ),
      ),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  final firebaseAuth = FirebaseAuth.instance;

  late SharedPreferences sharedPreferences;
  late Future<bool> hasOpened;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> getSharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return (sharedPreferences.getBool('hasOpened') ?? false);
  }

  setSharedPrefs(){
    sharedPreferences.setBool('hasOpened', true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getSharedPrefs(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData){
          if (snapshot.data ?? false) {
            return const SplashScreen(
              nextScreen: LandingPage(),
              useLottie: true,
            );
          } else {
            setSharedPrefs();
            return const SplashScreen(
              nextScreen: OnBoardingScreen(),
              useLottie: true,
            );
          }
        }else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
/*
bool hasOpened = (prefs!.getBool('hasOpened') ?? false);
    if (hasOpened) {
      setSharedPrefs();
      return const SplashScreen(
        nextScreen: OnBoardingScreen(),
        useLottie: true,
      );
    } else {
      return const SplashScreen(
        nextScreen: OnBoardingScreen(),
        useLottie: false,
      );
    }
 */
