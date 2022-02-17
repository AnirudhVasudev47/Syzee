import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/services/categories_service.dart';
import 'package:syzee/ui/screen/products_screen.dart';
import 'package:syzee/ui/screen/sub_category_screen.dart';

class CategoryListTile extends StatelessWidget {
  const CategoryListTile({
    Key? key,
    required this.image,
    required this.name,
    required this.id,
    required this.cat,
  }) : super(key: key);

  final String image;
  final String name;
  final int id;
  final MainCategory cat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        loadingDialog(context, asset: AssetConstants.loadingLottie);
        bool val = await checkCategory(id, cat);
        Navigator.pop(context);
        print(val);
        if (val) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubCategoryScreen(
                id: id,
                name: name,
                image: '${AssetConstants.mockImageLink}/category/$image',
                cat: cat,
              ),
            ),
          );
        } else {
          if (name.contains('New')) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductsScreen(
                  cat: cat,
                  subCatId: 0,
                  from: 'newIn',
                ),
              ),
            );
          }
        }
      },
      child: Container(
        alignment: Alignment.bottomLeft,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(
          horizontal: 26,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: const ColorFilter.mode(Color(0x26000000), BlendMode.multiply),
            image: NetworkImage(
              '${AssetConstants.mockImageLink}/category/$image',
            ),
            fit: BoxFit.cover,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: 204,
        child: Text(
          name,
          style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
