import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';

class SingleProductScreen extends StatefulWidget {
  const SingleProductScreen({Key? key}) : super(key: key);

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  final CarouselController carouselController = CarouselController();
  int current = 0;

  List<String> list = [
    'assets/images/single_product/product.png',
    'assets/images/single_product/product.png',
    'assets/images/single_product/product.png',
    'assets/images/single_product/product.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AssetConstants.customAppBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                  aspectRatio: 407 / 389,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  onPageChanged: (index, _) {
                    setState(() {
                      current = index;
                    });
                  }),
              items: list
                  .map(
                    (item) => Image.asset(
                      item,
                      height: 407,
                      width: MediaQuery.of(context).size.width,
                    ),
                  )
                  .toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: list.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => carouselController.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (carouselController.ready
                              ? const Color(0xff9A6D4A)
                              : Colors.black)
                          .withOpacity(current == entry.key ? 0.9 : 0.4),
                    ),
                  ),
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/images/single_product/share.png',
                    height: 30,
                    width: 30,
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xff169B93),
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 25,
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      const Text(
                        'Complete The Look',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'assets/images/single_product/complete.png',
                        height: 30,
                        width: 30,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ).copyWith(top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Seasonal Pick',
                        style:
                            TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                      ),
                      Text(
                        'Gucci',
                        style:
                            TextStyle(fontFamily: 'Montserrat', fontSize: 22),
                      ),
                      Text(
                        'Checkered Shirt',
                        style:
                            TextStyle(fontFamily: 'Montserrat', fontSize: 13),
                      ),
                    ],
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xff169B93),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 25,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Tailor Size available',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 25.0,
                top: 8,
              ),
              child: Text(
                'QAR 120',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff009C95)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                top: 8,
              ),
              child: Row(
                children: [
                  const Text(
                    'Color : Yellow ',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 17,
                    ),
                  ),
                  Container(
                    height: 14,
                    width: 14,
                    decoration: BoxDecoration(
                      color: const Color(0xffB2732B),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 2,
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
