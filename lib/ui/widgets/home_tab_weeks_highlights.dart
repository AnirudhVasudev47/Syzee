import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/week_highlights_model.dart';
import 'package:syzee/services/home_tab.dart';
import 'package:syzee/ui/screen/single_product_screen.dart';

class HomeTabWeeksHighlights extends StatefulWidget {
  const HomeTabWeeksHighlights({Key? key}) : super(key: key);

  @override
  _HomeTabWeeksHighlightsState createState() => _HomeTabWeeksHighlightsState();
}

class _HomeTabWeeksHighlightsState extends State<HomeTabWeeksHighlights> {
  int current = 0;
  final CarouselController carouselController = CarouselController();
  late Future<WeekHighlightsModel> week;

  var list = [1,2,3];

  @override
  void initState() {
    super.initState();
    week = getWeekHighlights();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: week,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          WeekHighlightsModel weekData = snapshot.data as WeekHighlightsModel;
          return Column(
            children: [
              CarouselSlider(
                carouselController: carouselController,
                items: weekData.data
                    .map(
                      (item) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleProductScreen(
                            id: item.productId,
                            mainCat: item.mainCatId == 'women'
                                ? MainCategory.women
                                : item.mainCatId == 'kids'
                                ? MainCategory.kids
                                : MainCategory.men,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          '${AssetConstants.mockImageLink}/week_highlights/${item.image}',
                          height: 225,
                        ),
                        Text(
                          item.title,
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
                  aspectRatio: 343/315,
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
                children: weekData.data.asMap().entries.map((entry) {
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
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
