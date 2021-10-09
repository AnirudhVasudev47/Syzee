import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeTabWeeksHighlights extends StatefulWidget {
  const HomeTabWeeksHighlights({Key? key}) : super(key: key);

  @override
  _HomeTabWeeksHighlightsState createState() => _HomeTabWeeksHighlightsState();
}

class _HomeTabWeeksHighlightsState extends State<HomeTabWeeksHighlights> {
  int current = 0;
  final CarouselController carouselController = CarouselController();

  var list = [1,2,3];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: carouselController,
          items: list
              .map(
                  (item) => InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/home/home_tab/week.png',
                        ),
                        const Text(
                          'For Beach and beyond',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const Text(
                          'New season cover up and swimwear',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
          ).toList(),
          options: CarouselOptions(
            aspectRatio: 343/330,
            viewportFraction: 0.7,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            onPageChanged: (index, _) {
              setState(() {
                current = index;
              });
            },
          ),
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
                      ? const Color(0xff2d2a2a)
                      : Colors.black)
                      .withOpacity(current == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
