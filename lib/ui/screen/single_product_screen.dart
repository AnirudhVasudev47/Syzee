import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/models/product.dart';
import 'package:syzee/models/review_model.dart';
import 'package:syzee/models/sizing_profile_model.dart';
import 'package:syzee/services/cart_services.dart';
import 'package:syzee/services/color_code_convert.dart';
import 'package:syzee/services/product.dart';
import 'package:syzee/services/sizing_service.dart';
import 'package:syzee/services/wishlist_services.dart';
import 'package:syzee/ui/screen/cart_screen.dart';
import 'package:syzee/ui/screen/complete_look_screen.dart';
import 'package:syzee/ui/screen/size_guide_screen.dart';
import 'package:syzee/ui/widgets/appbar.dart';
import 'package:syzee/ui/widgets/review_card.dart';
import 'package:syzee/ui/widgets/sizing_profile_card.dart';
import 'package:syzee/ui/widgets/update_or_add_size.dart';

import 'login_screen.dart';

class SingleProductScreen extends StatefulWidget {
  const SingleProductScreen({
    Key? key,
    required this.id,
    required this.mainCat,
  }) : super(key: key);

  final String id;
  final MainCategory mainCat;

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  final firebaseAuth = FirebaseAuth.instance;
  final CarouselController carouselController = CarouselController();
  late var product;
  int current = 0;
  SizeVariant? _chosenValue;
  bool isWished = false;
  String imageLink = '';
  late Future<ReviewModel> reviews;

  int sizeIndex = 0;
  int colorIndex = 0;
  int initIndex = -1;

  late Future<SizingProfileModel> sizing;

  @override
  void initState() {
    super.initState();
    print('mainCat: ${widget.mainCat} prodId: ${widget.id}');
    setState(() {
      imageLink = widget.mainCat == MainCategory.women
          ? '${AssetConstants.mockImageLink}/women'
          : widget.mainCat == MainCategory.men
              ? '${AssetConstants.mockImageLink}/men'
              : '${AssetConstants.mockImageLink}/kids';
    });
    product = getProductService(widget.id, widget.mainCat);
    sizing = getAllSizingProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: FutureBuilder(
        future: product,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 'no/Product') {
              return Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      AssetConstants.couponEmpty,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                      repeat: false,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Product not found!',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                  ],
                ),
              );
            }
            Product product = snapshot.data as Product;
            reviews = getProductReviews(product.variants[0].id, widget.mainCat);
            product.variants[colorIndex].images.map((e) => print('image: $e \n'));
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  CarouselSlider(
                    carouselController: carouselController,
                    options: CarouselOptions(
                        aspectRatio: 407 / 389,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        onPageChanged: (index, _) {
                          setState(() {
                            current = index;
                          });
                        }),
                    items: product.variants[colorIndex].images
                        .map(
                          (item) => Image.network(
                        '$imageLink/$item',
                        height: 407,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    )
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: product.variants[colorIndex].images.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => carouselController.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                            (carouselController.ready ? const Color(0xff9A6D4A) : Colors.black)
                                .withOpacity(current == entry.key ? 0.9 : 0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // InkWell(
                      //   onTap: () {},
                      //   child: Image.asset(
                      //     'assets/images/single_product/share.png',
                      //     height: 30,
                      //     width: 30,
                      //   ),
                      // ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xff169B93),
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 25,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CompleteLookScreen(
                                sellerId: product.sellerId,
                                mainCatId: widget.mainCat,
                                prodStyle: widget.id,
                                prodImg: '$imageLink/${product.variants[colorIndex].images[0]}',
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            const Text(
                              'Complete The Look',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              'assets/images/single_product/complete.png',
                              height: 30,
                              width: 30,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ).copyWith(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 160,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.tagLine,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                product.brand,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        product.variants[colorIndex].tailorAssist == '1'
                            ? OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Color(0xff169B93),
                                    width: 1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 25,
                                  ),
                                ),
                                onPressed: () {
                                  showBottomSheet(
                                    context: context,
                                    enableDrag: true,
                                    builder: (context) {
                                      return BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                        child: FutureBuilder(
                                          future: sizing,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              SizingProfileModel size = snapshot.data as SizingProfileModel;
                                              return size.data.isEmpty
                                                  ? Column(
                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      children: [
                                                        Lottie.asset(
                                                          AssetConstants.sizeEmpty,
                                                          repeat: true,
                                                        ),
                                                        const Text(
                                                          'Add a size and get started',
                                                          style: TextStyle(
                                                            fontFamily: 'Montserrat',
                                                            fontSize: 18,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(
                                                            horizontal: 45.0,
                                                            vertical: 35,
                                                          ).copyWith(bottom: 22),
                                                          child: Builder(
                                                            builder: (context) {
                                                              return ElevatedButton(
                                                                onPressed: () {
                                                                  Scaffold.of(context).showBottomSheet<void>(
                                                                    (BuildContext context) {
                                                                      return BackdropFilter(
                                                                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                                                        child: SingleChildScrollView(
                                                                          child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                            children: [
                                                                              Container(
                                                                                height: 4,
                                                                                width: 80,
                                                                                alignment: Alignment.center,
                                                                                margin: const EdgeInsets.symmetric(
                                                                                  horizontal: 150,
                                                                                ),
                                                                                padding: const EdgeInsets.symmetric(
                                                                                  vertical: 75,
                                                                                ),
                                                                                decoration: const BoxDecoration(
                                                                                  color: Colors.blueGrey,
                                                                                  borderRadius: BorderRadius.all(
                                                                                    Radius.circular(30),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              UpdateOrAddSize(
                                                                                action: 'add',
                                                                                onFunctionComplete: () {
                                                                                  setState(() {
                                                                                    sizing = getAllSizingProfile();
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                  primary: const Color(0xff169B93),
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                  ),
                                                                  padding: const EdgeInsets.symmetric(
                                                                    vertical: 10,
                                                                    horizontal: 45,
                                                                  ),
                                                                ),
                                                                child: const Text(
                                                                  'Add Size Profile',
                                                                  style: TextStyle(
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.w500,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : ListView.builder(
                                                      shrinkWrap: true,
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      itemCount: size.data.length,
                                                      itemBuilder: (context, index) {
                                                        return SizingProfileCard(
                                                          showEdit: false,
                                                          heightUnit: size.data[index].heightUnit,
                                                          height: size.data[index].height,
                                                          weight: size.data[index].weight,
                                                          weightUnit: size.data[index].weightUnit,
                                                          selectedId: size.selectedId.toString(),
                                                          id: size.data[index].id.toString(),
                                                          onTapCard: () async {
                                                            SharedPreferences prefs = await SharedPreferences.getInstance();

                                                            if (firebaseAuth.currentUser == null) {
                                                              displayToast(
                                                                context,
                                                                title: 'Please login to continue',
                                                                desc: 'You hav not logged in. Please login to continue',
                                                              );

                                                              Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => const LoginScreen(),
                                                                ),
                                                              );
                                                            } else {
                                                              loadingDialog(context, asset: 'assets/images/home/lottie/loading.json');

                                                              bool res = await addToCartWithTailor(
                                                                widget.mainCat,
                                                                '${product.variants[colorIndex].id}',
                                                                product.variants[colorIndex].sizeVariants[sizeIndex].size,
                                                                prefs.getString('userMail') ?? '',
                                                                size.data[index].height,
                                                                size.data[index].heightUnit,
                                                                size.data[index].weight,
                                                                size.data[index].weightUnit,
                                                                size.data[index].upperBody,
                                                                size.data[index].lowerBody,
                                                                size.data[index].length,
                                                                size.data[index].width,
                                                                size.data[index].chest,
                                                                size.data[index].sleevesFromNeck,
                                                                size.data[index].waist,
                                                                size.data[index].waistFromNeck,
                                                                size.data[index].chestFromNeck,
                                                                size.data[index].hips,
                                                              );
                                                              Navigator.pop(context);
                                                              if (res) {
                                                                displayToast(
                                                                  context,
                                                                  title: 'Success',
                                                                  desc: 'Item Successfully added to cart',
                                                                  type: 'success',
                                                                );
                                                              } else {
                                                                displayToast(
                                                                  context,
                                                                  title: 'Something went wrong',
                                                                  desc: 'Please try again later',
                                                                );
                                                              }

                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => const CartScreen(),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                          onFunctionComplete: () {
                                                            setState(() {
                                                              sizing = getAllSizingProfile();
                                                            });
                                                          },
                                                          onEdit: () {},
                                                        );
                                                      },
                                                    );
                                            } else {
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  Lottie.asset(
                                                    AssetConstants.loadingLottie,
                                                    repeat: true,
                                                  ),
                                                  const Text(
                                                    'Loading',
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 18,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              );
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Text(
                                  'Tailor Size available',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                      top: 8,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'QAR ${product.variants[colorIndex].sizeVariants[sizeIndex].price}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            decoration: product.variants[colorIndex]
                                .sizeVariants[sizeIndex].discount !=
                                ""
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            decorationStyle: TextDecorationStyle.solid,
                            decorationColor: Colors.blueGrey,
                            decorationThickness: 2,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff009C95),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        product.variants[colorIndex].sizeVariants[sizeIndex]
                            .discount !=
                            ""
                            ? Text(
                          'QAR ${product.variants[colorIndex].sizeVariants[sizeIndex].discount}',
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff009C95),
                          ),
                        )
                            : Container(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        top: 8,
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(8),
                        itemCount: product.variants.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Text(
                              'Color: ${product.variants[colorIndex].colorName}',
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 17,
                              ),
                            );
                          } else {
                            return InkWell(
                              onTap: () {
                                reviews = getProductReviews(product.variants[index - 1].id, widget.mainCat);
                                setState(() {
                                  colorIndex = index - 1;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                  color: HexColor(product.variants[index - 1].color),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3,
                                      spreadRadius: 2,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  product.variants[colorIndex].chartStatus == 1
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 25.0,
                            top: 8,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SizeGuideScreen(
                                    productId: product.variants[colorIndex].id,
                                    mainCat: widget.mainCat,
                                    prodImg: '$imageLink/${product.variants[colorIndex].images[0]}',
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'View size guide',
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                            ),
                          ),
                        )
                      : Container(),
                  // Container(
                  //   padding: const EdgeInsets.only(top: 25),
                  //   alignment: Alignment.center,
                  //   child: OutlinedButton(
                  //     style: OutlinedButton.styleFrom(
                  //       side: const BorderSide(
                  //         color: Color(0xff169B93),
                  //         width: 1,
                  //       ),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(0.0),
                  //       ),
                  //       padding: const EdgeInsets.symmetric(
                  //         vertical: 10,
                  //         horizontal: 25,
                  //       ),
                  //     ),
                  //     onPressed: () {},
                  //     child: const Text(
                  //       'Find your size with our Size Assistant',
                  //       style:
                  //           TextStyle(fontFamily: 'Montserrat', fontSize: 16, color: Colors.black),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 25,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff009C95),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: DropdownButton<SizeVariant>(
                      focusColor: Colors.white,
                      value: _chosenValue,
                      //elevation: 5,
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: product.variants[colorIndex].sizeVariants.map((value) {
                        return DropdownMenuItem<SizeVariant>(
                          value: value,
                          child: Text(
                            value.size,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      hint: const Padding(
                        padding: EdgeInsets.only(right: 25),
                        child: Text(
                          "Select a Size",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        print(product.variants[colorIndex].sizeVariants.indexOf(value!));
                        setState(() {
                          _chosenValue = value;
                          sizeIndex = product.variants[colorIndex].sizeVariants.indexOf(value);
                          initIndex = product.variants[colorIndex].sizeVariants.indexOf(value);
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();

                            if (firebaseAuth.currentUser == null) {
                              displayToast(
                                context,
                                title: 'Please login to continue',
                                desc: 'You hav not logged in. Please login to continue',
                              );

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            } else {
                              if (initIndex == -1) {
                                return displayToast(
                                  context,
                                  title: 'Select a size',
                                  desc: 'Size not selected. Please select a size to continue',
                                );
                              }
                              loadingDialog(context, asset: 'assets/images/home/lottie/loading.json');

                              bool res = await addToCart(
                                widget.mainCat,
                                '${product.variants[colorIndex].id}',
                                product.variants[colorIndex].sizeVariants[sizeIndex].size,
                                prefs.getString('userMail') ?? '',
                              );
                              Navigator.pop(context);
                              if (res) {
                                displayToast(
                                  context,
                                  title: 'Success',
                                  desc: 'Item Successfully added to cart',
                                  type: 'success',
                                );
                              } else {
                                displayToast(
                                  context,
                                  title: 'Something went wrong',
                                  desc: 'Please try again later',
                                );
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartScreen(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xff169B93),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 45,
                            ),
                          ),
                          child: const Text(
                            'ADD TO SHOPPING BAG',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            loadingDialog(context);
                            if (isWished) {
                              removeFromWishlist(
                                  widget.mainCat == MainCategory.women
                                      ? '1'
                                      : widget.mainCat == MainCategory.kids
                                          ? '2'
                                          : '3',
                                  product.variants[colorIndex].id);
                            } else {
                              await addToWishlist(
                                  widget.mainCat == MainCategory.women
                                      ? '1'
                                      : widget.mainCat == MainCategory.kids
                                          ? '2'
                                          : '3',
                                  product.variants[colorIndex].id,
                                  product.variants[colorIndex].sizeVariants[sizeIndex].size);
                            }
                            setState(() {
                              isWished = !isWished;
                            });
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            isWished ? AssetConstants.heartActive : AssetConstants.heartInactive,
                            height: 35,
                            width: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ).copyWith(top: 25, bottom: 8),
                    child: const Text(
                      'Product Details',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Text(
                      product.description,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 13,
                      ),
                    ),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 25,
                  //   ).copyWith(top: 25, bottom: 8),
                  //   child: const Text(
                  //     'Size & Fit',
                  //     style: TextStyle(
                  //       fontFamily: 'Montserrat',
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 25,
                  //   ),
                  //   child: const Text(
                  //     'The model size is 5,6"',
                  //     style: TextStyle(
                  //       fontFamily: 'Montserrat',
                  //       fontSize: 13,
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 25,
                  //   ).copyWith(top: 25, bottom: 8),
                  //   child: const Text(
                  //     'Material & care',
                  //     style: TextStyle(
                  //       fontFamily: 'Montserrat',
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 25,
                  //   ),
                  //   child: const Text(
                  //     'Top Fabric\nAvoid direct wash with hands',
                  //     style: TextStyle(
                  //       fontFamily: 'Montserrat',
                  //       fontSize: 13,
                  //     ),
                  //   ),
                  // ),
                  FutureBuilder(
                    future: reviews,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        ReviewModel revList = snapshot.data as ReviewModel;
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ).copyWith(top: 25, bottom: 8),
                              child: Row(
                                children: [
                                  const Text(
                                    'Reviews',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    ' ${revList.data.length}',
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xff7F7F7F),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ).copyWith(top: 13, bottom: 8),
                              child: Row(
                                children: [
                                  Text(
                                    revList.average.toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 29,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Image.asset(
                                    'assets/images/single_product/star.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                ],
                              ),
                            ),
                            revList.data.isEmpty
                                ? const Text(
                                    'No reviews Yet',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: revList.data.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                        ).copyWith(top: 25, bottom: 8),
                                        child: ReviewCard(
                                          name: revList.data[index].userEmail,
                                          review: revList.data[index].description,
                                          date: revList.data[index].createdOn.toString(),
                                          rate: double.parse(revList.data[index].reviewValue),
                                        ),
                                      );
                                    },
                                  ),
                          ],
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 34,
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
