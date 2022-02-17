import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/categories_tile_model.dart';
import 'package:syzee/services/categories_service.dart';
import 'package:syzee/ui/layouts/category_list_tile.dart';

class CategoryKids extends StatefulWidget {
  const CategoryKids({Key? key}) : super(key: key);

  @override
  State<CategoryKids> createState() => _CategoryKidsState();
}

class _CategoryKidsState extends State<CategoryKids> {
  late Future<List<CategoryTileModel>> list;

  @override
  void initState() {
    super.initState();
    list = getKidsCategories();
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
                id: categories[index].id,
                cat: MainCategory.kids,
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
