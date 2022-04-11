import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/product_list_model.dart';
import 'package:syzee/services/product.dart';
import 'package:syzee/ui/layouts/product_tile.dart';
import 'package:syzee/ui/screen/single_product_screen.dart';
import 'package:syzee/ui/widgets/appbar.dart';

class CompleteLookScreen extends StatefulWidget {
  const CompleteLookScreen({
    Key? key,
    required this.sellerId,
    required this.prodStyle,
    required this.mainCatId,
    required this.prodImg,
  }) : super(key: key);

  final String sellerId;
  final String prodStyle;
  final MainCategory mainCatId;
  final String prodImg;

  @override
  State<CompleteLookScreen> createState() => _CompleteLookScreenState();
}

class _CompleteLookScreenState extends State<CompleteLookScreen> {
  String imageLink = '';
  late Future<List<ProductTileModel>> prodList;

  @override
  void initState() {
    super.initState();
    prodList = getCompleteLook(widget.mainCatId, widget.prodStyle, widget.sellerId);

    setState(() {
      imageLink = widget.mainCatId == MainCategory.women
          ? '${AssetConstants.mockImageLink}/women'
          : widget.mainCatId == MainCategory.men
          ? '${AssetConstants.mockImageLink}/men'
          : '${AssetConstants.mockImageLink}/kids';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 35,
              ).copyWith(top: 25),
              child: Image.network(
                widget.prodImg,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              indent: 75,
              endIndent: 75,
              color: Color(0xffB6874A),
              height: 5,
              thickness: 5,
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Complete the look',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 25,
            ),
            FutureBuilder(
              future: prodList,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<ProductTileModel> data = snapshot.data as List<ProductTileModel>;
                  if (data.length < 2) {
                    return const Center(
                      child: Text('Sorry no products found'),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 168,
                        height: 305,
                        child: ProductTile(
                          name: data[0].name,
                          brand: data[0].brand,
                          price: data[0].price,
                          image: '$imageLink/${data[0].image}',
                          isWished: data[0].wishlist,
                          onTapCard: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SingleProductScreen(
                                  id: data[0].id,
                                  mainCat: widget.mainCatId,
                                ),
                              ),
                            );
                          },
                          onTapHeart: () {
                            setState(() {
                              prodList = getCompleteLook(widget.mainCatId, widget.prodStyle, widget.sellerId);
                            });
                          },
                          size: data[0].size,
                          productId: data[0].productId.toString(),
                          mainCatId: widget.mainCatId == MainCategory.women
                              ? '1'
                              : widget.mainCatId == MainCategory.kids
                                  ? '2'
                                  : '3',
                        ),
                      ),
                      SizedBox(
                        width: 168,
                        height: 305,
                        child: ProductTile(
                          name: data[1].name,
                          brand: data[1].brand,
                          price: data[1].price,
                          image: '$imageLink/${data[1].image}',
                          isWished: data[1].wishlist,
                          onTapCard: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SingleProductScreen(
                                  id: data[1].id,
                                  mainCat: widget.mainCatId,
                                ),
                              ),
                            );
                          },
                          onTapHeart: () {
                            setState(() {
                              prodList = getCompleteLook(widget.mainCatId, widget.prodStyle, widget.sellerId);
                            });
                          },
                          size: data[1].size,
                          productId: data[1].productId.toString(),
                          mainCatId: widget.mainCatId == MainCategory.women
                              ? '1'
                              : widget.mainCatId == MainCategory.kids
                              ? '2'
                              : '3',
                        ),
                      )
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
