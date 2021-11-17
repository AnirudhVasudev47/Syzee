import 'package:flutter/material.dart';

class HomeTabCategoriesLayout extends StatefulWidget {
  const HomeTabCategoriesLayout({Key? key, required this.image, required this.name})
      : super(key: key);

  final String image;
  final String name;

  @override
  _HomeTabCategoriesLayoutState createState() => _HomeTabCategoriesLayoutState();
}

class _HomeTabCategoriesLayoutState extends State<HomeTabCategoriesLayout> {
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
            Image.network(
              widget.image,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              height: 150,
              width: 150,
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
