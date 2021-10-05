import 'package:flutter/material.dart';

class BrandProductTile extends StatelessWidget {
  const BrandProductTile(
      {Key? key,
      required this.name,
      required this.brand,
      required this.price,
      required this.image})
      : super(key: key);

  final String name;
  final String brand;
  final int price;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 207,
            height: 232,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              color: Color(0xffEAE5D7),
            ),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        brand,
                        style: const TextStyle(
                          fontFamily: 'VarelaRound',
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '\$' + price.toString(),
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            color: Color(0xff009C95)),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Image.asset(
                          'assets/images/home/cart.png',
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Image.asset(
                          'assets/images/home/heart.png',
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
