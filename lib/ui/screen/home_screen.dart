import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:syzee/global/color.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/theme.dart';
import 'package:syzee/services/bottom_nav_provider.dart';
import 'package:syzee/ui/screen/Tabs/brand_tab.dart';
import 'package:syzee/ui/screen/Tabs/categories_tab.dart';
import 'package:syzee/ui/screen/Tabs/home_tab.dart';
import 'package:syzee/ui/screen/Tabs/profile_tab.dart';
import 'package:syzee/ui/screen/Tabs/wishlist_tab.dart';
import 'package:syzee/ui/widgets/appbar.dart';

class HomePage extends StatefulWidget {

  final int? customIndex;

  const HomePage({Key? key, this.customIndex}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firebaseAuth = FirebaseAuth.instance;
  ScreenUtil screenUtil = ScreenUtil();
  GlobalKey scaffoldKey = GlobalKey();
  double iconSize = 20;
  int indexOpen = 0;

  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
    indexOpen = widget.customIndex ?? 0;
  }

  _indexChange(int index) {
    setState(() {
      indexOpen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      HomeTab(
        changeTab: _indexChange,
      ),
      CategoriesTab(
        index: 0,
        changeTab: _indexChange,
      ),
      const BrandTab(),
      const WishlistTab(),
      const ProfileTab(),
    ];
    return Scaffold(
      appBar: const CustomAppBar(),
      key: scaffoldKey,
      body: Builder(
        builder: (context) => SafeArea(
          // top: false,
          child: Container(
            child: _widgetOptions[indexOpen],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AssetConstants.home,
                color: ThemeColors.iconInActiveColor,
                height: iconSize,
                width: iconSize,
              ),
              activeIcon: SvgPicture.asset(
                AssetConstants.homeActive,
                color: ThemeColors.iconActiveColor,
                height: iconSize,
                width: iconSize,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetConstants.categories,
              color: ThemeColors.iconInActiveColor,
              height: iconSize,
              width: iconSize,
            ),
            activeIcon: SvgPicture.asset(
              AssetConstants.categoriesActive,
              color: ThemeColors.iconActiveColor,
              height: iconSize,
              width: iconSize,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetConstants.brand,
              color: ThemeColors.iconInActiveColor,
              height: iconSize,
              width: iconSize,
            ),
            activeIcon: SvgPicture.asset(
              AssetConstants.brandActive,
              color: ThemeColors.iconActiveColor,
              height: iconSize,
              width: iconSize,
            ),
            label: 'Brand',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetConstants.wish,
              color: ThemeColors.iconInActiveColor,
              height: iconSize,
              width: iconSize,
            ),
            activeIcon: SvgPicture.asset(
              AssetConstants.wishActive,
              color: ThemeColors.iconActiveColor,
              height: iconSize,
              width: iconSize,
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetConstants.profile,
              color: ThemeColors.iconInActiveColor,
              height: iconSize,
              width: iconSize,
            ),
            activeIcon: SvgPicture.asset(
              AssetConstants.profileActive,
              color: ThemeColors.iconActiveColor,
              height: iconSize,
              width: iconSize,
            ),
            label: 'Profile',
          ),
        ],
        iconSize: 14,
        backgroundColor: ThemeColors.navPillColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: indexOpen,
        selectedItemColor: ThemeColors.iconActiveColor,
        unselectedItemColor: ThemeColors.iconInActiveColor,
        onTap: _indexChange,
      ),
    );
  }
}
