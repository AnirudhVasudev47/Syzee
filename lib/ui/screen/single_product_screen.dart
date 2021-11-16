import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/ui/screen/cart_screen.dart';
import 'package:syzee/ui/screen/complete_look_screen.dart';
import 'package:syzee/ui/screen/size_guide_screen.dart';
import 'package:syzee/ui/widgets/review_card.dart';

class SingleProductScreen extends StatefulWidget {
  const SingleProductScreen({Key? key}) : super(key: key);

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  final CarouselController carouselController = CarouselController();
  int current = 0;
  String? _chosenValue;
  bool isWished = false;

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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CompleteLookScreen(),
                      ),
                    );
                  },
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
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                top: 8,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SizeGuideScreen(),
                    ),
                  );
                },
                child: const Text(
                  'View size guide',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 25),
              alignment: Alignment.center,
              child: OutlinedButton(
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
                  'Find your size with our Size Assistant',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: Colors.black),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 25,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff009C95),
                ),
              ),
              alignment: Alignment.center,
              child: DropdownButton<String>(
                focusColor: Colors.white,
                value: _chosenValue,
                //elevation: 5,
                style: const TextStyle(color: Colors.white),
                iconEnabledColor: Colors.black,
                items: <String>[
                  'XXL',
                  'XL',
                  'L',
                  'M',
                  'S',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
                hint: const Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: Text(
                    "Select a Size",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _chosenValue = value;
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff169B93),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 45,
                      ),
                    ),
                    child: const Text(
                      'ADD TO SHOPPING BAG',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isWished = !isWished;
                      });
                    },
                    child: Image.asset(
                      isWished
                          ? AssetConstants.heartActive
                          : AssetConstants.heartInactive,
                      height: 35,
                      width: 35,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ).copyWith(top: 25, bottom: 8),
              child: const Text(
                'Product Details',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: const Text(
                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est.',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ).copyWith(top: 25, bottom: 8),
              child: const Text(
                'Size & Fit',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: const Text(
                'The model size is 5,6"',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ).copyWith(top: 25, bottom: 8),
              child: const Text(
                'Material & care',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: const Text(
                'Top Fabric\nAvoid direct wash with hands',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ).copyWith(top: 25, bottom: 8),
              child: Row(
                children: const [
                  Text(
                    'Reviews',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    ' 1236',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xff7F7F7F),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ).copyWith(top: 13, bottom: 8),
              child: Row(
                children: [
                  const Text(
                    '4.5',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 29,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Image.asset(
                    'assets/images/single_product/star.png',
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  const Text(
                    '1663 Verified Buyers',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ).copyWith(top: 25, bottom: 8),
              child: const ReviewCard(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ).copyWith(top: 25, bottom: 25),
              child: const ReviewCard(),
            ),
          ],
        ),
      ),
    );
  }
}
