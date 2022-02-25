import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/wishlist_modal.dart';
import 'package:syzee/services/wishlist_services.dart';
import 'package:syzee/ui/layouts/product_tile.dart';
import 'package:syzee/ui/screen/single_product_screen.dart';

class WishlistProductList extends StatefulWidget {
  const WishlistProductList({Key? key, required this.wishData})
      : super(key: key);

  final WishlistModal wishData;

  @override
  State<WishlistProductList> createState() => _WishlistProductListState();
}

class _WishlistProductListState extends State<WishlistProductList> {

  @override
  Widget build(BuildContext context) {
    WishlistModal wish = widget.wishData;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: wish.data.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 10,
          childAspectRatio: 168 / 290,
        ),
        itemBuilder: (context, index) {
          return ProductTile(
            name: wish.data[index].productName,
            brand: wish.data[index].tagLine,
            price: wish.data[index].price,
            image: wish.data[index].mainCatId == 1
                ? '${AssetConstants.mockImageLink}/women/${wish.data[index].image}'
                : wish.data[index].mainCatId == 2
                    ? '${AssetConstants.mockImageLink}/kids/${wish.data[index].image}'
                    : '${AssetConstants.mockImageLink}/men/${wish.data[index].image}',
            isWished: wish.data[index].wishlist,
            onTapHeart: () {},
            onTapCard: () async {
              var id = await getProductId(wish.data[index].mainCatId, wish.data[index].productId);

              print('prodId: $id');

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingleProductScreen(
                    id: id,
                    mainCat: wish.data[index].mainCatId == 1
                        ? MainCategory.women
                        : wish.data[index].mainCatId == 2
                        ? MainCategory.kids
                        : MainCategory.men,
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
