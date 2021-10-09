import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeTabBanner extends StatefulWidget {
  const HomeTabBanner({Key? key}) : super(key: key);

  @override
  _HomeTabBannerState createState() => _HomeTabBannerState();
}

class _HomeTabBannerState extends State<HomeTabBanner> {

  int current = 0;
  final CarouselController carouselController = CarouselController();

  List<String> list = [
    'assets/images/home/banner.png',
    'assets/images/home/banner.png',
    'assets/images/home/banner.png',
    'assets/images/home/banner.png',
    'assets/images/home/banner.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
              enlargeCenterPage: false,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index, _) {
                setState(() {
                  current = index;
                });
              }),
          items: list
              .map(
                (item) => Image.asset(item),
          )
              .toList(),
        ),
        Positioned(
          bottom: 10,
          right: 0,
          left: 0,
          child: Row(
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
                        ? Colors.white
                        : Colors.black)
                        .withOpacity(current == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
