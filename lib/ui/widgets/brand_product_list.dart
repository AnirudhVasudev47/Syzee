import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/single_brands_model.dart';
import 'package:syzee/ui/layouts/brand_product_list_tile.dart';
import 'package:syzee/ui/screen/single_product_screen.dart';

class BrandProductList extends StatefulWidget {
  final SingleBrandsModel model;

  const BrandProductList({Key? key, required this.model}) : super(key: key);

  @override
  State<BrandProductList> createState() => _BrandProductListState();
}

class _BrandProductListState extends State<BrandProductList> {

  @override
  Widget build(BuildContext context) {
    var data = widget.model.data;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: GridView.builder(
        itemCount: data.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 10,
          childAspectRatio: 217 / 415,
        ),
        itemBuilder: (context, index) {
          var imageLink = data[index].mainCatId == 1
              ? '${AssetConstants.mockImageLink}/women'
              : '${AssetConstants.mockImageLink}/kids';
          return BrandProductTile(
            name: data[index].name,
            brand: data[index].brand,
            price: data[index].price,
            image: '$imageLink/${data[index].image}',
            isWished: data[index].wishlist,
            onTapHeart: () {},
            onTapCard: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingleProductScreen(
                    mainCat: data[index].mainCatId == 1
                        ? MainCategory.women
                        : data[index].mainCatId == 2
                            ? MainCategory.kids
                            : MainCategory.men,
                    id: data[index].id,
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
