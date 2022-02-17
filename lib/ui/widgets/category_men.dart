import 'package:flutter/material.dart';

class CategoryMen extends StatelessWidget {
  const CategoryMen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Coming Soon',
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
