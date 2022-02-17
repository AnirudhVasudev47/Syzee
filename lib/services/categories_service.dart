import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/categories_tile_model.dart';
import 'package:syzee/models/sub_category_model.dart';

Uri womenCategories =
    Uri.parse('${AssetConstants.mockApiLink}/categories/women');
Uri kidsCategories = Uri.parse('${AssetConstants.mockApiLink}/categories/kids');
Uri subCategories = Uri.parse('${AssetConstants.mockApiLink}/sub_category');
Uri checkSubCategories = Uri.parse('${AssetConstants.mockApiLink}/check_sub_category');

Future<List<CategoryTileModel>> getWomenCategories() async {
  final res = await http.get(womenCategories);
  var data = jsonDecode(res.body);
  List<CategoryTileModel> finList = [];
  data.forEach((cate) => {finList.add(CategoryTileModel.fromJson(cate))});
  return finList;
}

Future<List<CategoryTileModel>> getKidsCategories() async {
  final res = await http.get(kidsCategories);
  var data = jsonDecode(res.body);
  List<CategoryTileModel> finList = [];
  data.forEach((cate) => {finList.add(CategoryTileModel.fromJson(cate))});
  return finList;
}

Future<List<SubCategoryModel>> getSubCategoryList(int catId, MainCategory cat) async {
  Map<String, dynamic> subCatMap = {};
  subCatMap['categoryId'] = '$catId';
  if (cat == MainCategory.women) {
    subCatMap['mainCatId'] = '1';
  }
  if (cat == MainCategory.men) {
    subCatMap['mainCatId'] = '3';
  }
  if (cat == MainCategory.kids) {
    subCatMap['mainCatId'] = '2';
  }
  var response = await http.post(subCategories, body: subCatMap);
  // print(jsonDecode(response.body));
  var data = jsonDecode(response.body);
  List<SubCategoryModel> finList = [];
  data.forEach((subCate) => {finList.add(SubCategoryModel.fromJson(subCate))});
  return finList;
}


// Middleware

Future<bool> checkCategory (int catId, MainCategory cat) async {
  Map<String, String> subCatCheckMap = {};
  subCatCheckMap['categoryId'] = '$catId';
  if (cat == MainCategory.women) {
    subCatCheckMap['mainCatId'] = '1';
  }
  if (cat == MainCategory.men) {
    subCatCheckMap['mainCatId'] = '3';
  }
  if (cat == MainCategory.kids) {
    subCatCheckMap['mainCatId'] = '2';
  }
  // print(subCatCheckMap);
  var response = await http.post(checkSubCategories, body: subCatCheckMap);
  // print(response.body);
  var data = jsonDecode(response.body)['data'];
  // print(data);
  if (data == 'present/sub-categories') {
    return true;
  } else {
    return false;
  }
}
