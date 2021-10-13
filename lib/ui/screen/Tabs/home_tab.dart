import 'package:flutter/material.dart';
import 'package:syzee/global/theme.dart';
import 'package:syzee/models/product_list_model.dart';
import 'package:syzee/ui/layouts/product_tile.dart';
import 'package:syzee/ui/widgets/home_tab_banner.dart';
import 'package:syzee/ui/widgets/home_tab_blogger_list.dart';
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
      wishlist: true,
    ),
    ProductTileModel(
      price: 14,
      name: 'Women checks',
      image: 'assets/images/pink.png',
      brand: 'Allen Solly',
      wishlist: true,
    ),
    ProductTileModel(
      price: 24,
      name: 'Flower women ',
      image: 'assets/images/black.png',
      brand: 'Trends',
      wishlist: true,
    ),
    ProductTileModel(
      price: 12,
      name: 'Women pink dress',
      image: 'assets/images/white.png',
      brand: 'ZARA',
      wishlist: true,
    ),
  ];

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
            child: const Text(
              'Good morning! Welcome :)',
              textAlign: TextAlign.start,
              style: TextStyle(
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: const [
                HomeTabCategories(
                  image: 'assets/images/home/home_tab/category1.png',
                  name: 'Clothing',
                ),
                HomeTabCategories(
                  image: 'assets/images/home/home_tab/category2.png',
                  name: 'Shoes',
                ),
                HomeTabCategories(
                  image: 'assets/images/home/home_tab/category3.png',
                  name: 'Bags',
                ),
              ],
            ),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SizedBox(
                    width: 168,
                    height: 305,
                    child: ProductTile(
                      name: listData[0].name,
                      brand: listData[0].brand,
                      price: listData[0].price,
                      image: listData[0].image,
                      isWished: listData[0].wishlist,
                      onTapCard: () {},
                      onTapHeart: () {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SizedBox(
                    width: 168,
                    height: 305,
                    child: ProductTile(
                      name: listData[1].name,
                      brand: listData[1].brand,
                      price: listData[1].price,
                      image: listData[1].image,
                      isWished: listData[1].wishlist,
                      onTapCard: () {},
                      onTapHeart: () {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SizedBox(
                    width: 168,
                    height: 305,
                    child: ProductTile(
                      name: listData[2].name,
                      brand: listData[2].brand,
                      price: listData[2].price,
                      image: listData[2].image,
                      isWished: listData[2].wishlist,
                      onTapCard: () {},
                      onTapHeart: () {
                        setState(() {
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SizedBox(
                    width: 168,
                    height: 305,
                    child: ProductTile(
                      name: listData[3].name,
                      brand: listData[3].brand,
                      price: listData[3].price,
                      image: listData[3].image,
                      isWished: listData[3].wishlist,
                      onTapCard: () {},
                      onTapHeart: () {},
                    ),
                  ),
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
              'This week\'s Highlights',
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
