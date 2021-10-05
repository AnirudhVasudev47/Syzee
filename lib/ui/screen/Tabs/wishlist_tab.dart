import 'package:flutter/material.dart';
import 'package:syzee/ui/widgets/wishlist_product_list.dart';

enum SelectedTab {
  products,
  brands,
}

class WishlistTab extends StatefulWidget {
  const WishlistTab({Key? key, this.tab}) : super(key: key);

  final SelectedTab? tab;

  @override
  State<WishlistTab> createState() => _WishlistTabState();
}

class _WishlistTabState extends State<WishlistTab> {
  SelectedTab selectedTab = SelectedTab.products;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedTab = widget.tab ?? SelectedTab.products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Favourites',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 21,
                  color: Color(0xff009B93),
                ),
              ),
              Image.asset(
                'assets/images/home/heart.png',
                height: 27,
                width: 27,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            selectedTab == SelectedTab.products
                ? ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedTab = SelectedTab.brands;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff169B93),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 45,
                      ),
                    ),
                    child: const Text(
                      'Products',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  )
                : OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xff169B93),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 45,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedTab = SelectedTab.products;
                      });
                    },
                    child: const Text(
                      'Products',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
            selectedTab == SelectedTab.brands
                ? ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedTab = SelectedTab.products;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff169B93),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 45,
                      ),
                    ),
                    child: const Text(
                      'Brands',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  )
                : OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xff169B93),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 45,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedTab = SelectedTab.brands;
                      });
                    },
                    child: const Text(
                      'Brands',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
          ],
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: WishlistProductList(),
          ),
        ),
      ],
    );
  }
}
