import 'package:flutter/material.dart';
import 'package:syzee/ui/widgets/product_or_brand.dart';
import 'package:syzee/ui/widgets/wishlist_product_list.dart';

class WishlistTab extends StatefulWidget {
  const WishlistTab({Key? key, this.tab}) : super(key: key);

  final SelectedTab? tab;

  @override
  State<WishlistTab> createState() => _WishlistTabState();
}

class _WishlistTabState extends State<WishlistTab> {
  bool isProducts = true;

  @override
  void initState() {
    super.initState();
    setState(() {
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
        ProductOrBrand(
          tab: SelectedTab.products,
          isProduct: isProducts,
          onTap: () {
            setState(() {
              isProducts = !isProducts;
            });
          },
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
