import 'package:flutter/material.dart';

class LookOfTheDay extends StatelessWidget {
  const LookOfTheDay(
      {Key? key,
      required this.image,
      required this.product,
      required this.discount})
      : super(key: key);

  final String image;
  final String product;
  final String discount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,
            width: 116,
            height: 121,
          ),
          Text(
            product,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            discount,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
