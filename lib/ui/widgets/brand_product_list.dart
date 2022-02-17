import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/ui/layouts/brand_product_list_tile.dart';
import 'package:syzee/ui/screen/single_product_screen.dart';

class BrandProductList extends StatefulWidget {
  const BrandProductList({Key? key}) : super(key: key);

  @override
  State<BrandProductList> createState() => _BrandProductListState();
}

class _BrandProductListState extends State<BrandProductList> {
  var listData = [
    BrandProductTile(
      price: 34,
      brand: 'Gucci shirts',
      image: 'assets/images/home/brands_tab/image1.png',
      name: 'Men\'s Cotton shirt',
      isWished: true,
      onTapCard: () {},
      onTapHeart: () {},
    ),
    BrandProductTile(
      price: 14,
      brand: 'Gucci T Shirt',
      image: 'assets/images/home/brands_tab/image2.png',
      name: 'White men t-shirt',
      isWished: true,
      onTapCard: () {},
      onTapHeart: () {},
    ),
    BrandProductTile(
      price: 24,
      brand: 'Gucci shoes',
      image: 'assets/images/home/brands_tab/image3.png',
      name: 'Black Women shoes',
      isWished: true,
      onTapCard: () {},
      onTapHeart: () {},
    ),
    BrandProductTile(
      price: 12,
      brand: 'Gucci belt',
      image: 'assets/images/home/brands_tab/image4.png',
      name: 'Pure leather belt',
      isWished: true,
      onTapCard: () {},
      onTapHeart: () {},
    ),
  ];

  var wishedList = [
    false,
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,),
      child: GridView.builder(
        itemCount: listData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 10,
          childAspectRatio: 168/290,
        ),
        itemBuilder: (context, index) {
          return BrandProductTile(
            name: listData[index].name,
            brand: listData[index].brand,
            price: listData[index].price,
            image: listData[index].image,
            isWished: wishedList[index],
            onTapHeart: () {
              setState(() {
                wishedList[index] = !wishedList[index];
              });
            },
            onTapCard: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SingleProductScreen(
                    mainCat: MainCategory.women,
                    id: 'SYZEEWOMEN001',
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
