import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syzee/global/theme.dart';
import 'package:syzee/ui/screen/cart_screen_empty.dart';

enum MainCategory {
  women,
  men,
  kids,
}

class AssetConstants {
  static const mockApiLink = 'http://syzee.co:8000/api';
  static const mockWebLink = 'http://syzee.co';
  static const mockImageLink = 'http://syzee.co/images';

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

  static const loadingLottie = 'assets/images/home/lottie/loading.json';
  static const couponEmpty = 'assets/images/home/lottie/coupon_empty.json';
  static const addressEmpty = 'assets/images/home/lottie/address.json';
  static const sizeEmpty = 'assets/images/home/lottie/empty_size.json';

  static const searchIcon = 'assets/images/home/search.png';
  static const cancelIcon = 'assets/images/home/cancel.png';
  static const arrowUpRight = 'assets/images/home/arrow_up.png';

}