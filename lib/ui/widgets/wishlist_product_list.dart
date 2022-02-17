import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/product_list_model.dart';
import 'package:syzee/ui/layouts/product_tile.dart';
import 'package:syzee/ui/screen/single_product_screen.dart';

class WishlistProductList extends StatefulWidget {
  const WishlistProductList({Key? key}) : super(key: key);

  @override
  State<WishlistProductList> createState() => _WishlistProductListState();
}

class _WishlistProductListState extends State<WishlistProductList> {
  var listData = [
    ProductTileModel(
      id: '1',
      price: 34,
      name: 'Red women dress',
      image: 'assets/images/578.png',
      brand: 'ZARA',
      wishlist: true,
    ),
    ProductTileModel(
      id: '1',
      price: 14,
      name: 'Women checks',
      image: 'assets/images/pink.png',
      brand: 'Allen Solly',
      wishlist: true,
    ),
    ProductTileModel(
      id: '1',
      price: 24,
      name: 'Flower women ',
      image: 'assets/images/black.png',
      brand: 'Trends',
      wishlist: true,
    ),
    ProductTileModel(
      id: '1',
      price: 12,
      name: 'Women pink dress',
      image: 'assets/images/white.png',
      brand: 'ZARA',
      wishlist: true,
    ),
  ];

  var wishlistState = [
    true,
    true,
    true,
    true,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: listData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 10,
          childAspectRatio: 168/290,
        ),
        itemBuilder: (context, index) {
          return ProductTile(
            name: listData[index].name,
            brand: listData[index].brand,
            price: listData[index].price,
            image: listData[index].image,
            isWished: wishlistState[index],
            onTapHeart: () {
              setState(() {
                wishlistState[index] = !wishlistState[index];
              });
            },
            onTapCard: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SingleProductScreen(
                    id: 'SYZEEWOMEN001',
                    mainCat: MainCategory.women,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/*
 ListView.builder(
      itemCount: listData.length,
      itemBuilder: (context, index) {
        return  ProductTile(
          name: listData[index].name,
          brand: listData[index].brand,
          price: listData[index].price,
          image: listData[index].image,
        );
      },
    )
 */
