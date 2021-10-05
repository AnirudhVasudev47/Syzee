import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/services/bottom_nav_provider.dart';
import 'package:syzee/ui/screen/home_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff009C95), Color(0xff0B4E4A)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(top: 120, bottom: 50.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 100,
                  child: Image.asset(AssetConstants.logo),
                ),
                Column(
                  children: [
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.75,
                      padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff0B4E4A)),
                        child: const Text(
                          'SHOP WOMEN',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider<
                                  BottomNavigationBarProvider>(
                                child: const HomePage(),
                                create: (BuildContext context) =>
                                    BottomNavigationBarProvider(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.75,
                      padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff0B4E4A)),
                        child: const Text(
                          'SHOP KIDS',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider<
                                  BottomNavigationBarProvider>(
                                child: const HomePage(),
                                create: (BuildContext context) =>
                                    BottomNavigationBarProvider(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.75,
                      padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff0B4E4A)),
                        child: const Text(
                          'SHOP MEN',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider<
                                  BottomNavigationBarProvider>(
                                child: const HomePage(),
                                create: (BuildContext context) =>
                                    BottomNavigationBarProvider(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
