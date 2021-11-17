import 'package:flutter/material.dart';

class HomeTabMostWanted extends StatelessWidget {
  const HomeTabMostWanted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color(0xffFAFAFA),
          child: Image.asset(
            'assets/images/home/home_tab/wanted.png',
            height: 208,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.contain,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            'Discover our daily edit of must-have shoes, iconic bags, clothing favorites and more',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 25,
          ),
          child: InkWell(
            onTap: () {},
            child: const Text(
              'SHOP NOW',
              textAlign: TextAlign.center,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Color(0xffAE765C),
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
