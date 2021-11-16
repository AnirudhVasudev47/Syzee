import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';

class SizeGuideScreen extends StatelessWidget {
  const SizeGuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AssetConstants.customAppBar,
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Size Guide',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Image.asset(
            'assets/images/single_product/size_guide2.png',
            width: MediaQuery.of(context).size.width,
          )
        ],
      ),
    );
  }
}
