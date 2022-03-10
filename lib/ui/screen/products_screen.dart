import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/product_list_model.dart';
import 'package:syzee/services/products_services.dart';
import 'package:syzee/ui/widgets/appbar.dart';
import 'package:syzee/ui/widgets/product_or_brand.dart';
import 'package:syzee/ui/widgets/product_screen_product_list.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen(
      {Key? key, required this.cat, required this.subCatId, required this.from})
      : super(key: key);

  final MainCategory cat;
  final int subCatId;
  final String from;

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool isProducts = true;
  late Future<List<ProductTileModel>> list;
  final firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    if (widget.from == 'sub_category') {
      if (firebaseAuth.currentUser == null) {
        list = getProductsList(widget.cat, widget.subCatId);
      } else {
        list = getProductsListByUser(widget.cat, widget.subCatId);
      }
    } else if (widget.from == 'newIn'){
      list = getProductFromNewIn(widget.cat, widget.subCatId);
      // print(list.toString());
    } else if (widget.from == 'allClothing'){
      list = getAllProducts(widget.cat, widget.subCatId);
      // print(list.toString());
    } else if (widget.from == 'gifts'){
      list = getGifts(widget.cat, widget.subCatId);
      // print(list.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: FutureBuilder(
                future: list,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ProductTileModel> data = snapshot.data as List<ProductTileModel>;
                    print('data: $data');
                    return ProductScreenProductList(
                      mainCat: widget.cat,
                      list: data,
                      onWishTap: () {
                        if (widget.from == 'sub_category') {
                          if (firebaseAuth.currentUser == null) {
                            setState(() {
                              list = getProductsList(widget.cat, widget.subCatId);
                            });
                          } else {
                            setState(() {
                              list = getProductsListByUser(widget.cat, widget.subCatId);
                            });
                          }
                        } else if (widget.from == 'newIn') {
                          setState(() {
                            list = getProductFromNewIn(widget.cat, widget.subCatId);
                          });
                          // print(list.toString());
                        }
                      }, subCatId: widget.subCatId, from: widget.from,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
