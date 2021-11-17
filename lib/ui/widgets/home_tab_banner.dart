import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:syzee/services/home_tab.dart';

class HomeTabBanner extends StatefulWidget {
  const HomeTabBanner({Key? key}) : super(key: key);

  @override
  _HomeTabBannerState createState() => _HomeTabBannerState();
}

class _HomeTabBannerState extends State<HomeTabBanner> {
  int current = 0;
  final CarouselController carouselController = CarouselController();
  late Future<List<String>> bannerList;
  double headerAspect = 415/200;

  @override
  void initState() {
    super.initState();
    bannerList = getBanner();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: bannerList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String> images = snapshot.data as List<String>;
          print(images);
          return Stack(
            children: [
              CarouselSlider(
                carouselController: carouselController,
                options: CarouselOptions(
                    enlargeCenterPage: false,
                    aspectRatio: headerAspect,
                    viewportFraction: 1,
                    autoPlay: false,
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    onPageChanged: (index, _) {
                      setState(() {
                        current = index;
                      });
                    }),
                items: images
                    .map(
                      (item) => Image.network(
                        item,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, chunk) {
                          if (chunk == null) {
                            return child;
                          }
                          return SkeletonLoader(
                            builder: AspectRatio(
                              aspectRatio: headerAspect,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.white,
                              ),
                            ),
                            items: 1,
                            period: const Duration(seconds: 2),
                            highlightColor: const Color(0xffd7d7d7),
                            direction: SkeletonDirection.ltr,
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
              Positioned(
                bottom: 10,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: images.asMap().entries.map((entry) {
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
        } else {
          return SkeletonLoader(
            builder: AspectRatio(
              aspectRatio: headerAspect,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
              ),
            ),
            items: 1,
            period: const Duration(seconds: 2),
            highlightColor: const Color(0xffaed7d7),
            direction: SkeletonDirection.ltr,
          );
        }
      },
    );
  }
}

/*
Stack(
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
    )
 */