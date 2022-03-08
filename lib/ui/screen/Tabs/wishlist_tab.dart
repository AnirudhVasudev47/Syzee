import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syzee/models/wishlist_modal.dart';
import 'package:syzee/services/wishlist_services.dart';
import 'package:syzee/ui/widgets/product_or_brand.dart';
import 'package:syzee/ui/widgets/wishlist_product_list.dart';

class WishlistTab extends StatefulWidget {
  const WishlistTab({Key? key, this.tab}) : super(key: key);

  final SelectedTab? tab;

  @override
  State<WishlistTab> createState() => _WishlistTabState();
}

class _WishlistTabState extends State<WishlistTab> {
  final firebaseAuth = FirebaseAuth.instance;
  late Future<WishlistModal> wishData;

  @override
  void initState() {
    super.initState();
    wishData = getWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return firebaseAuth.currentUser == null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Favourites',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 21,
                        color: Color(0xff009B93),
                      ),
                    ),
                    Image.asset(
                      'assets/images/home/heart.png',
                      height: 27,
                      width: 27,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/home/warning.png',
                        height: 150,
                        width: 150,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Please login to continue',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Favourites',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 21,
                        color: Color(0xff009B93),
                      ),
                    ),
                    Image.asset(
                      'assets/images/home/heart.png',
                      height: 27,
                      width: 27,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: FutureBuilder(
                      future: wishData,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          WishlistModal wish = snapshot.data as WishlistModal;
                          return WishlistProductList(
                            onTap: () async {
                              var wishRes = getWishlist();
                              setState(() {
                                wishData = wishRes;
                              });
                            },
                            wishData: wish,
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )),
              ),
            ],
          );
  }
}
