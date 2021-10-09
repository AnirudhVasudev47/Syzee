import 'package:flutter/material.dart';

class HomeTabCategories extends StatefulWidget {
  const HomeTabCategories({Key? key, required this.image, required this.name})
      : super(key: key);

  final String image;
  final String name;

  @override
  _HomeTabCategoriesState createState() => _HomeTabCategoriesState();
}

class _HomeTabCategoriesState extends State<HomeTabCategories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Image.asset(
              widget.image,
              height: 150,
            ),
            Text(
              widget.name,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
