import 'package:flutter/material.dart';
import 'package:syzee/models/product_list_model.dart';
import 'package:syzee/ui/layouts/product_tile.dart';
import 'package:syzee/ui/screen/single_product_screen.dart';
import 'package:syzee/ui/widgets/home_tab_banner.dart';
import 'package:syzee/ui/widgets/home_tab_blogger_list.dart';
import 'package:syzee/ui/layouts/home_tab_categories.dart';
import 'package:syzee/ui/widgets/home_tab_categories.dart';
import 'package:syzee/ui/widgets/home_tab_influencers_stories.dart';
import 'package:syzee/ui/widgets/home_tab_most_wanted.dart';
import 'package:syzee/ui/widgets/home_tab_weeks_highlights.dart';
import 'package:syzee/ui/widgets/look_of_the_day.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var listData = [
    ProductTileModel(
      price: 34,
      name: 'Red women dress',
      image: 'assets/images/578.png',
      brand: 'ZARA',
      wishlist: false,
    ),
    ProductTileModel(
      price: 14,
      name: 'Women checks',
      image: 'assets/images/pink.png',
      brand: 'Allen Solly',
      wishlist: false,
    ),
    ProductTileModel(
      price: 24,
      name: 'Flower women ',
      image: 'assets/images/black.png',
      brand: 'Trends',
      wishlist: false,
    ),
    ProductTileModel(
      price: 12,
      name: 'Women pink dress',
      image: 'assets/images/white.png',
      brand: 'ZARA',
      wishlist: false,
    ),
  ];

  var wishData = [
    false,
    false,
    false,
    false,
  ];

  DateTime now = DateTime.now();

  String greetingText = '';

  getGreet() {
    if (now.hour < 12) {
      greetingText = 'Good Morning! ';
    } else if (now.hour >= 12) {
      greetingText = 'Good Afternoon! ';
    } else {
      greetingText = 'Good Evening! ';
    }
  }

  @override
  void initState() {
    super.initState();
    getGreet();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 25,
            ),
            color: const Color.fromRGBO(0, 0, 0, 0.65),
            child: Text(
              greetingText + 'Welcome :)',
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 19,
                color: Colors.white,
              ),
            ),
          ),
          const HomeTabBanner(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 10,
            ),
            child: const Text(
              'Shop By Category',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 178,
            child: const HomeTabCategories(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 10,
            ),
            child: const Text(
              'Shop By Brand',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/images/home/home_tab/brand1.png',
                    width: 170,
                    height: 224,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/images/home/home_tab/brand2.png',
                    width: 170,
                    height: 224,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/images/home/home_tab/brand3.png',
                    width: 170,
                    height: 224,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/images/home/home_tab/brand4.png',
                    width: 170,
                    height: 224,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35,
            ),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.black,
                side: const BorderSide(
                  color: Colors.black,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: const Text(
                  'BROWSE ALL BRANDS',
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 25,
            ),
            child: Divider(
              height: 0,
              thickness: 1,
              indent: 25,
              endIndent: 25,
              color: Color(0xffE7D1A8),
            ),
          ),
          const HomeTabInfluencerStories(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
            child: const Text(
              'Most Popular',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 310,
            child: ListView.builder(
              itemCount: listData.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SizedBox(
                    width: 168,
                    height: 305,
                    child: ProductTile(
                      name: listData[index].name,
                      brand: listData[index].brand,
                      price: listData[index].price,
                      image: listData[index].image,
                      isWished: wishData[index],
                      onTapCard: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SingleProductScreen(),
                          ),
                        );
                      },
                      onTapHeart: () {
                        setState(() {
                          wishData[index] = !wishData[index];
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 25,
            ),
            child: Divider(
              height: 0,
              thickness: 1,
              indent: 25,
              endIndent: 25,
              color: Color(0xffE7D1A8),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: const [
                HomeTabBloggerList(
                  image: 'assets/images/home/home_tab/blogger1.png',
                  name: 'Blogger Women',
                ),
                HomeTabBloggerList(
                  image: 'assets/images/home/home_tab/blogger2.png',
                  name: 'Blogger Man',
                ),
                HomeTabBloggerList(
                  image: 'assets/images/home/home_tab/blogger1.png',
                  name: 'Women',
                ),
                HomeTabBloggerList(
                  image: 'assets/images/home/home_tab/blogger2.png',
                  name: 'Man',
                ),
                HomeTabBloggerList(
                  image: 'assets/images/home/home_tab/blogger1.png',
                  name: 'Women',
                ),
                HomeTabBloggerList(
                  image: 'assets/images/home/home_tab/blogger2.png',
                  name: 'Man',
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 25,
            ),
            child: Divider(
              height: 0,
              thickness: 1,
              indent: 25,
              endIndent: 25,
              color: Color(0xffE7D1A8),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ).copyWith(bottom: 25, top: 10),
            child: const Text(
              'Look of the day',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: const [
                LookOfTheDay(
                  image: 'assets/images/home/home_tab/shirt.png',
                  product: 'Yellow checkered \nshirt - XL',
                  discount: '20%off',
                ),
                LookOfTheDay(
                  image: 'assets/images/home/home_tab/pants.png',
                  product: 'Biege cargo \npants - XL',
                  discount: '20%off',
                ),
                LookOfTheDay(
                  image: 'assets/images/home/home_tab/shoe.png',
                  product: 'Woodland \nCameo shoes',
                  discount: '20%off',
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 25,
            ),
            child: const Text(
              'This week\'s Highlights',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            ),
          ),
          const HomeTabWeeksHighlights(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 25,
            ),
            child: const Text(
              'Most Wanted',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const HomeTabMostWanted(),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 25,
            ),
            child: Image.asset(
              'assets/images/home/home_tab/banner1.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 25,
            ),
            child: Image.asset(
              'assets/images/home/home_tab/banner2.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.black,
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: const Text(
              'Couldn\'t find something your were looking for?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontSize: 14,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 25),
            padding: const EdgeInsets.only(top: 8),
            color: const Color(0xffD3D4D6),
            child: Column(
              children: [
                const Text(
                  'We can help you find it, Please answer these\nsimple questions.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0).copyWith(top: 15),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Get Started',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:  Colors.black,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                        Container(
                          child: Image.asset(
                            'assets/images/home/home_tab/arrow.png',
                            width: 25,
                            height: 25,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 25,
            ),
            child: Image.asset(
              'assets/images/home/home_tab/banner3.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
