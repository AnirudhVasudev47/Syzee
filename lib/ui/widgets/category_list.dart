import 'package:flutter/material.dart';
import 'package:syzee/models/categories_tile_model.dart';
import 'package:syzee/ui/layouts/category_list_tile.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  var listData = [
    CategoryTileModel(
        count: 300, name: 'Clothes', image: 'assets/images/Component27.png'),
    CategoryTileModel(
        count: 200, name: 'Beauty', image: 'assets/images/Group118.png'),
    CategoryTileModel(
        count: 400, name: 'Clothes', image: 'assets/images/Component27.png'),
    CategoryTileModel(
        count: 100, name: 'Beauty', image: 'assets/images/Group118.png'),
    CategoryTileModel(
        count: 600, name: 'Clothes', image: 'assets/images/Component27.png'),
    CategoryTileModel(
        count: 200, name: 'Beauty', image: 'assets/images/Group118.png'),
    CategoryTileModel(
        count: 700, name: 'Clothes', image: 'assets/images/Component27.png'),
    CategoryTileModel(
        count: 300, name: 'Beauty', image: 'assets/images/Group118.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listData.length,
      itemBuilder: (context, index) {
        return CategoryListTile(
          image: listData[index].image,
          name: listData[index].name,
          count: listData[index].count,
        );
      },
    );
  }
}
