import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/models/product.dart';
import 'package:syzee/services/cart_services.dart';
import 'package:syzee/services/color_code_convert.dart';
import 'package:syzee/services/product.dart';
import 'package:syzee/ui/screen/complete_look_screen.dart';
import 'package:syzee/ui/screen/size_guide_screen.dart';
import 'package:syzee/ui/widgets/appbar.dart';
import 'package:syzee/ui/widgets/review_card.dart';

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
  late Future<Product> product;
  int current = 0;
  SizeVariant? _chosenValue;
  bool isWished = false;
  String imageLink = '';

  int sizeIndex = 0;
  int colorIndex = 0;

  List<Color> color = [
    Colors.amber,
    Colors.blueGrey,
    Colors.red,
    Colors.lightGreen,
    Colors.black54,
  ];

  @override
  void initState() {
    super.initState();
    print ('mainCat: ${widget.mainCat} prodId: ${widget.id}');
    setState(() {
      imageLink = widget.mainCat == MainCategory.women
          ? '${AssetConstants.mockImageLink}/women'
          : widget.mainCat == MainCategory.men
              ? '${AssetConstants.mockImageLink}/men'
              : '${AssetConstants.mockImageLink}/kids';
    });

    product = getProductService(widget.id, widget.mainCat);
    print('data: ' '${product.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: FutureBuilder(
        future: product,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Product product = snapshot.data as Product;
            product.variants[colorIndex].images.map((e) => print('image: $e \n'));
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      InkWell(
                        onTap: () {},
                        child: Image.asset(
                          'assets/images/single_product/share.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
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
                              builder: (context) => const CompleteLookScreen(),
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
                          onPressed: () {},
                          child: const Text(
                            'Tailor Size available',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 13,
                            ),
                          ),
                        ),
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
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough,
                            decorationStyle: TextDecorationStyle.solid,
                            decorationColor: Colors.blueGrey,
                            decorationThickness: 2,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff009C95),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'QAR ${product.variants[colorIndex].sizeVariants[sizeIndex].discount}',
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff009C95),
                          ),
                        ),
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
                                print(color[index - 1]);
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
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                      top: 8,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SizeGuideScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'View size guide',
                        style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 25),
                    alignment: Alignment.center,
                    child: OutlinedButton(
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
                      onPressed: () {},
                      child: const Text(
                        'Find your size with our Size Assistant',
                        style:
                            TextStyle(fontFamily: 'Montserrat', fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
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
                            } else {
                              loadingDialog(context,
                                  asset: 'assets/images/home/lottie/loading.json');

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
                            }

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const CartScreen(),
                            //   ),
                            // );
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
                          onTap: () {
                            setState(() {
                              isWished = !isWished;
                            });
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ).copyWith(top: 25, bottom: 8),
                    child: Row(
                      children: const [
                        Text(
                          'Reviews',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          ' 1236',
                          style: TextStyle(
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
                        const Text(
                          '4.5',
                          style: TextStyle(
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
                        const SizedBox(
                          width: 24,
                        ),
                        const Text(
                          '1663 Verified Buyers',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ).copyWith(top: 25, bottom: 8),
                    child: const ReviewCard(),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ).copyWith(top: 25, bottom: 25),
                    child: const ReviewCard(),
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
