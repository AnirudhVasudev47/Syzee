import 'package:flutter/material.dart';

class SizingProfileCardLayout extends StatelessWidget {
  const SizingProfileCardLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 25,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Color(0x29656161),
            offset: Offset(0, 2),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column (
        children: [
          Text(
            'Me',
            style: TextStyle(
              fontFamily: 'Montserrat'
            ),
          )
        ],
      )
    );
  }
}
