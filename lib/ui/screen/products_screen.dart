import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/ui/widgets/product_or_brand.dart';
import 'package:syzee/ui/widgets/product_screen_product_list.dart';
import 'package:syzee/ui/widgets/sort_filter_button.dart';
import 'package:syzee/ui/widgets/wishlist_product_list.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  bool isProducts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AssetConstants.customAppBar,
      body: Column(
        children: [
          const SortFilterButton(),
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
              child: ProductScreenProductList(),
            ),
          ),
        ],
      ),
    );
  }
}
