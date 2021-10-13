import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syzee/global/color.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/ui/screen/products_screen.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({Key? key, required this.name, required this.image})
      : super(key: key);

  final String name;
  final String image;

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  var listData = [
    'All Dresses',
    'Midi Dresses',
    'Maxi Dresses',
    'Mini Dresses',
    'Knee Length Dresses',
    'Gowns',
    'Party Dresses',
    'Evening Dresses',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AssetConstants.customAppBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              widget.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 24,
                color: Color(0xff009B93),
              ),
            ),
          ),
          Image.asset(
            widget.image,
            height: 254,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listData.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductsScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 25,
                        ),
                        child: Text(
                          listData[index],
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color(0xffEEEEEE),
                      height: 2,
                      thickness: 2,
                      indent: 25,
                      endIndent: 25,
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
