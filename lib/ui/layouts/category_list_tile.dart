import 'package:flutter/material.dart';

class CategoryListTile extends StatelessWidget {
  const CategoryListTile({
    Key? key,
    required this.image,
    required this.name,
    required this.count,
  }) : super(key: key);

  final String image;
  final String name;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      margin: const EdgeInsets.symmetric(
        vertical: 5
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 26,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: 204,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          Text(
            count.toString() + ' Items',
            style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 11,
                color: Colors.white,
                fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
