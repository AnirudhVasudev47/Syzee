import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/theme.dart';

class SizingProfileScreen extends StatelessWidget {
  const SizingProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: currentTheme.currentTheme == ThemeMode.dark
            ? Colors.black
            : Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset(
          AssetConstants.blackLogo,
          fit: BoxFit.contain,
          height: 55,
          width: 104,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          SizedBox(
            height: 10,
          ),
          Text(
            'Saved Sizes',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 24,
              color: Color(0xff009C95),
            ),
            textAlign: TextAlign.center,
          ),

        ],
      ),
    );
  }
}
