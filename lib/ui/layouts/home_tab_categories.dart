import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/ui/screen/products_screen.dart';

class HomeTabCategoriesLayout extends StatefulWidget {
  const HomeTabCategoriesLayout(
      {Key? key,
      required this.image,
      required this.name,
      required this.subCatId,
      required this.mainCat})
      : super(key: key);

  final String image;
  final String name;
  final int subCatId;
  final MainCategory mainCat;

  @override
  _HomeTabCategoriesLayoutState createState() =>
      _HomeTabCategoriesLayoutState();
}

class _HomeTabCategoriesLayoutState extends State<HomeTabCategoriesLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsScreen(
                cat: widget.mainCat,
                subCatId: widget.subCatId,
                from: 'category',
              ),
            ),
          );
        },
        child: Column(
          children: [
            Image.network(
              widget.image,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              height: 150,
              width: 150,
            ),
            Text(
              widget.name,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
