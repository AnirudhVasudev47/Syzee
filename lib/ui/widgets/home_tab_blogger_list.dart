import 'package:flutter/material.dart';

class HomeTabBloggerList extends StatefulWidget {
  const HomeTabBloggerList({Key? key, required this.image, required this.name})
      : super(key: key);

  final String image;
  final String name;

  @override
  _HomeTabBloggerListState createState() => _HomeTabBloggerListState();
}

class _HomeTabBloggerListState extends State<HomeTabBloggerList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          child: InkWell(
            borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
            onTap: () {},
            child: Image.asset(
              widget.image,
              height: 75,
            ),
          ),
        ),
        Text(
          widget.name,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 10
          ),
        )
      ],
    );
  }
}
