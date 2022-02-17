import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/ui/layouts/product_tile.dart';
import 'package:syzee/ui/screen/single_product_screen.dart';
import 'package:syzee/ui/widgets/appbar.dart';

class CompleteLookScreen extends StatefulWidget {
  const CompleteLookScreen({Key? key}) : super(key: key);

  @override
  State<CompleteLookScreen> createState() => _CompleteLookScreenState();
}

class _CompleteLookScreenState extends State<CompleteLookScreen> {
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
              child: Image.asset(
                'assets/images/single_product/product.png',
                fit: BoxFit.contain,
              ),
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
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 168,
                  height: 305,
                  child: ProductTile(
                    name: 'Cargo Pants',
                    brand: 'Gucci',
                    price: 4000,
                    image: 'assets/images/home/home_tab/pants.png',
                    isWished: true,
                    onTapCard: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SingleProductScreen(
                            id: 'SYZEEWOMEN001',
                            mainCat: MainCategory.women,
                          ),
                        ),
                      );
                    },
                    onTapHeart: () {
                      setState(() {
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 168,
                  height: 305,
                  child: ProductTile(
                    name: 'Leather brown shoes',
                    brand: 'Gucci',
                    price: 4000,
                    image: 'assets/images/home/home_tab/shoe.png',
                    isWished: true,
                    onTapCard: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SingleProductScreen(
                            id: 'SYZEEWOMEN001',
                            mainCat: MainCategory.women,
                          ),
                        ),
                      );
                    },
                    onTapHeart: () {
                      setState(() {
                      });
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
