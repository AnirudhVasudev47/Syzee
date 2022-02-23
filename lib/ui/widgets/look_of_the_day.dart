import 'package:flutter/material.dart';

class LookOfTheDay extends StatelessWidget {
  const LookOfTheDay(
      {Key? key,
      required this.image,
      required this.product,
      required this.discount,
      required this.onTap})
      : super(key: key);

  final String image;
  final String product;
  final String discount;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              image,
              width: 116,
              height: 121,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            Expanded(
              flex: 2,
              child: Text(
                product,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                discount,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
