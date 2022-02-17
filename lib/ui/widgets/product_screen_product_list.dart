import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/product_list_model.dart';
import 'package:syzee/ui/layouts/product_tile.dart';
import 'package:syzee/ui/screen/single_product_screen.dart';

class ProductScreenProductList extends StatefulWidget {
  const ProductScreenProductList({
    Key? key,
    required this.list,
    required this.onWishTap,
    required this.mainCat,
  }) : super(key: key);

  final List<ProductTileModel> list;
  final VoidCallback onWishTap;
  final MainCategory mainCat;

  @override
  State<ProductScreenProductList> createState() => _ProductScreenProductListState();
}

class _ProductScreenProductListState extends State<ProductScreenProductList> {
  String imageLink = '';

  @override
  void initState() {
    super.initState();

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
    print(widget.list.length);
    return widget.list.isEmpty
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
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: widget.list.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 10,
                childAspectRatio: 168 / 290,
              ),
              itemBuilder: (context, index) {
                return ProductTile(
                  name: widget.list[index].name,
                  brand: widget.list[index].brand,
                  price: widget.list[index].price,
                  image: '$imageLink/${widget.list[index].image}',
                  isWished: widget.list[index].wishlist,
                  onTapHeart: widget.onWishTap,
                  onTapCard: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleProductScreen(
                          mainCat: widget.mainCat,
                          id: widget.list[index].id,
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
      itemCount: list.length,
      itemBuilder: (context, index) {
        return  ProductTile(
          name: list[index].name,
          brand: list[index].brand,
          price: list[index].price,
          image: list[index].image,
        );
      },
    )
 */
