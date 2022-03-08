import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/services/wishlist_services.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key? key,
    required this.name,
    required this.brand,
    required this.price,
    required this.image,
    required this.isWished,
    required this.onTapHeart,
    required this.onTapCard,
    required this.size,
    required this.productId,
    required this.mainCatId,
  }) : super(key: key);

  final String name;
  final String brand;
  final int price;
  final String image;
  final bool isWished;
  final Function () onTapHeart;
  final VoidCallback onTapCard;
  final String size;
  final String productId;
  final String mainCatId;

  @override
  Widget build(BuildContext context) {
    print(image);
    return InkWell(
      onTap: onTapCard,
      child: Column(
        children: [
          Container(
            width: 207,
            height: 225,
            padding: const EdgeInsets.symmetric(
              horizontal: 0
            ),
            decoration: const BoxDecoration(
              color: Color(0xffEAE5D7),
            ),
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        brand,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'VarelaRound',
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'QAR ' + price.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontFamily: 'Montserrat', fontSize: 18, color: Color(0xff009C95)),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    loadingDialog(context);
                    if (isWished) {
                      removeFromWishlist(mainCatId, productId);
                    } else {
                      await addToWishlist(mainCatId, productId, size);
                    }
                    await onTapHeart();
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.asset(
                      isWished ? AssetConstants.heartActive : AssetConstants.heartInactive,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
