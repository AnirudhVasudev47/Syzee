import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/filter_model.dart';
import 'package:syzee/models/product_list_model.dart';
import 'package:syzee/services/products_services.dart';
import 'package:syzee/ui/layouts/product_tile.dart';
import 'package:syzee/ui/screen/single_product_screen.dart';
import 'package:syzee/ui/widgets/sort_filter_button.dart';

class ProductScreenProductList extends StatefulWidget {
  const ProductScreenProductList({
    Key? key,
    required this.list,
    required this.onWishTap,
    required this.mainCat,
    required this.subCatId,
    required this.from,
  }) : super(key: key);

  final List<ProductTileModel> list;
  final VoidCallback onWishTap;
  final MainCategory mainCat;
  final int subCatId;
  final String from;

  @override
  State<ProductScreenProductList> createState() => _ProductScreenProductListState();
}

class _ProductScreenProductListState extends State<ProductScreenProductList> {
  String imageLink = '';
  final firebaseAuth = FirebaseAuth.instance;
  late List<ProductTileModel> productList;
  List<String> colorList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      productList = widget.list;
    });

    setState(() {
      imageLink = widget.mainCat == MainCategory.women
          ? '${AssetConstants.mockImageLink}/women'
          : widget.mainCat == MainCategory.men
              ? '${AssetConstants.mockImageLink}/men'
              : '${AssetConstants.mockImageLink}/kids';
    });
  }

  @override
  Widget build(BuildContext context) {
    print(productList.isEmpty);
    return productList.isEmpty
        ? const Expanded(
            child: Center(
              child: Text(
                'Coming soon',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        : Column(
            children: [
              SortFilterButton(
                sortTile: -1,
                colorList: widget.list,
                onHtl: () {
                  setState(() {
                    productList.sort((a, b) => b.price.compareTo(a.price));
                  });
                },
                onLth: () {
                  setState(() {
                    productList.sort((a, b) => a.price.compareTo(b.price));
                  });
                },
                onNew: () {
                  setState(() {
                    productList.sort((a, b) => a.createdOn.compareTo(b.createdOn));
                  });
                },
                onOld: () {
                  setState(() {
                    productList.sort((a, b) => b.createdOn.compareTo(a.createdOn));
                  });
                },
                onView: (FilterModel filter) {
                  List<ProductTileModel> prod = widget.list;
                  prod = prod
                      .where((element) => ((element.price >= filter.filterOneValues[0] && element.price <= filter.filterOneValues[1]) &&
                          (double.parse(element.rating) >= filter.filterTwoValues[0] && double.parse(element.rating) <= filter.filterTwoValues[1]) &&
                          (filter.filterThreeValues == 'all' ? true : (element.color == filter.filterThreeValues))))
                      .toList();
                  print(prod);
                  setState(() {
                    productList = prod;
                  });
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: productList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 10,
                      childAspectRatio: 168 / 290,
                    ),
                    itemBuilder: (context, index) {
                      return ProductTile(
                        name: productList[index].name,
                        brand: productList[index].brand,
                        price: productList[index].price,
                        image: '$imageLink/${productList[index].image}',
                        isWished: productList[index].wishlist,
                        size: productList[index].size,
                        mainCatId: widget.mainCat == MainCategory.women
                            ? '1'
                            : widget.mainCat == MainCategory.kids
                                ? '2'
                                : '3',
                        productId: productList[index].productId.toString(),
                        onTapHeart: () async {
                          if (widget.from == 'sub_category') {
                            if (firebaseAuth.currentUser == null) {
                              var prod = await getProductsList(widget.mainCat, widget.subCatId);
                              setState(() {
                                productList = prod;
                              });
                            } else {
                              var prod = await getProductsListByUser(widget.mainCat, widget.subCatId);
                              setState(() {
                                productList = prod;
                              });
                            }
                          } else if (widget.from == 'newIn') {
                            var prod = await getProductFromNewIn(widget.mainCat, widget.subCatId);
                            setState(() {
                              productList = prod;
                            });
                            // print(list.toString());
                          } else if (widget.from == 'allClothing'){
                            var prod = await getAllProducts(widget.mainCat, widget.subCatId);
                            setState(() {
                              productList = prod;
                            });
                            // print(list.toString());
                          } else if (widget.from == 'gifts'){
                            var prod = await getGifts(widget.mainCat, widget.subCatId);
                            setState(() {
                              productList = prod;
                            });
                            // print(list.toString());
                          }
                          widget.onWishTap();
                        },
                        onTapCard: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SingleProductScreen(
                                mainCat: widget.mainCat,
                                id: productList[index].id,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
  }
}

/*
      productList.sort((a,b) => a.price.compareTo(b.price));
 */
