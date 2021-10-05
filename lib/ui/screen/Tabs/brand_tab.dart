import 'package:flutter/material.dart';
import 'package:syzee/ui/widgets/brand_product_list.dart';
import 'package:syzee/ui/widgets/wishlist_product_list.dart';

class BrandTab extends StatefulWidget {
  const BrandTab({Key? key}) : super(key: key);

  @override
  State<BrandTab> createState() => _BrandTabState();
}

class _BrandTabState extends State<BrandTab> {
  var listData = [
    'All',
    'Tops',
    'Sneakers',
    'Dress',
    'All',
    'Tops',
    'Sneakers',
    'Dress',
    'All',
    'Tops',
    'Sneakers',
    'Dress',
  ];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            children: [
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: Image.asset(
                  'assets/images/home/brands_tab/gucci.png',
                  fit: BoxFit.contain,
                  height: 50,
                  width: 50,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/home/heart.png',
                  height: 25,
                  width: 25,
                ),
              ),
            ],
          ),
        ),
        const Text(
          '2071 Items',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            itemCount: listData.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedTab = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: index == selectedTab
                            ? const Color(0xff0A5F5B)
                            : const Color(0xffD3D3D3),
                      ),
                    ),
                    child: Text(
                      listData.elementAt(index),
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          color: const Color.fromRGBO(0, 0, 0, 0.65),
          child: const Text(
            'Welcome to Gucci',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        const Expanded(
          child: BrandProductList(),
        )
      ],
    );
  }
}
