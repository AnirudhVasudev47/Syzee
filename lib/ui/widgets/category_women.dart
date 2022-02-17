import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/categories_tile_model.dart';
import 'package:syzee/services/categories_service.dart';
import 'package:syzee/ui/layouts/category_list_tile.dart';

class CategoryWomen extends StatefulWidget {
  const CategoryWomen({Key? key}) : super(key: key);

  @override
  State<CategoryWomen> createState() => _CategoryWomenState();
}

class _CategoryWomenState extends State<CategoryWomen> {
  late Future<List<CategoryTileModel>> list;

  @override
  void initState() {
    super.initState();
    list = getWomenCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: list,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CategoryTileModel> categories = snapshot.data as List<CategoryTileModel>;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryListTile(
                image: categories[index].image,
                name: categories[index].name,
                id: int.parse('${categories[index].id}'),
                cat: MainCategory.women,
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
