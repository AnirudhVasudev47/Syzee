import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syzee/global/constants.dart';

class CartEmptyScreen extends StatelessWidget {
  const CartEmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LottieBuilder.asset(
            AssetConstants.loadingLottie,
          ),
          Container(
            alignment: Alignment.center,
            child: const Text(
              'Your cart is empty add something and get started',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 34,
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff0B4E4A),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 24
                ),
                child: const Text(
                  'SHOP WOMEN',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
