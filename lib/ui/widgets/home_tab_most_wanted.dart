import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/most_wanted_model.dart';
import 'package:syzee/services/home_tab.dart';
import 'package:syzee/ui/screen/products_screen.dart';

class HomeTabMostWanted extends StatefulWidget {
  const HomeTabMostWanted({Key? key}) : super(key: key);

  @override
  State<HomeTabMostWanted> createState() => _HomeTabMostWantedState();
}

class _HomeTabMostWantedState extends State<HomeTabMostWanted> {
  int current = 0;
  final CarouselController carouselController = CarouselController();

  var list = [1, 2, 3];

  late var mostData;

  @override
  void initState() {
    super.initState();
    mostData = getMostWanted();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mostData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          MostWantedModel most = snapshot.data as MostWantedModel;
          return CarouselSlider(
            carouselController: carouselController,
            items: most.data
                .map(
                  (item) => Column(
                    children: [
                      Container(
                        color: const Color(0xffFAFAFA),
                        child: Image.network(
                          '${AssetConstants.mockImageLink}/product_images/${item.image}',
                          height: 208,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          item.heading,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 25,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductsScreen(
                                  cat: item.mainCategoryId == '1'
                                      ? MainCategory.women
                                      : item.mainCategoryId == '2'
                                          ? MainCategory.kids
                                          : MainCategory.men,
                                  subCatId: int.parse(item.subCategoryId),
                                  from: 'sub_category',
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'SHOP NOW',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xffAE765C),
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
            options: CarouselOptions(
              aspectRatio: 343 / 315,
              enlargeCenterPage: false,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index, _) {
                setState(() {
                  current = index;
                });
              },
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
