import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syzee/global/theme.dart';

class AssetConstants {

  static const mockApiLink = 'https://8be9-49-206-241-170.ngrok.io/api';

  static const logo = 'assets/images/logo.png';
  static const blackLogo = 'assets/images/logo1.png';

  static const home = 'assets/images/bottom_nav_bar/home.svg';
  static const homeActive = 'assets/images/bottom_nav_bar/home_active.svg';

  static const categories = 'assets/images/bottom_nav_bar/categories.svg';
  static const categoriesActive = 'assets/images/bottom_nav_bar/categories_active.svg';

  static const brand = 'assets/images/bottom_nav_bar/brand.svg';
  static const brandActive = 'assets/images/bottom_nav_bar/brand_active.svg';

  static const wish = 'assets/images/bottom_nav_bar/wishlist.svg';
  static const wishActive = 'assets/images/bottom_nav_bar/wishlist_active.svg';

  static const profile = 'assets/images/bottom_nav_bar/profile.svg';
  static const profileActive = 'assets/images/bottom_nav_bar/profile_active.svg';

  static const filter = 'assets/images/products_screen/filter.png';
  static const sort = 'assets/images/products_screen/sort.png';

  static const heartActive = 'assets/images/home/brands_tab/heart_active.png';
  static const heartInactive = 'assets/images/home/brands_tab/heart_inactive.png';

  static const bin = 'assets/images/checkout/bin.png';

  static PreferredSizeWidget customAppBar = (AppBar(
    elevation: 0,
    backgroundColor: currentTheme.currentTheme == ThemeMode.dark
        ? Colors.black
        : Colors.white,
    automaticallyImplyLeading: false,
    centerTitle: true,
    title: Image.asset(
      AssetConstants.blackLogo,
      fit: BoxFit.contain,
      height: 35,
      width: 104,
    ),
    leading: IconButton(
      icon: const Icon(
        Icons.search,
        size: 30,
        color: Color(0xff000000),
      ),
      onPressed: () {},
    ),
    actions: [
      Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SvgPicture.asset(
              'assets/images/home/appbar/bag.svg',
              width: 25,
              height: 25,
            ),
          ),
        ),
      ),
    ],
  ));

}