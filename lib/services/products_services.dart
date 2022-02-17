import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/product_list_model.dart';
import 'package:syzee/models/search_model.dart';

Uri prodListUri =
    Uri.parse('${AssetConstants.mockApiLink}/products_list/sub_category');
Uri prodListNewInUri =
    Uri.parse('${AssetConstants.mockApiLink}/product_list/newIn');
Uri searchUri =
    Uri.parse('${AssetConstants.mockApiLink}/products_list/search');

Future<List<ProductTileModel>> getProductsList(MainCategory cat, int subCatId) async {
  Map<String, String> prodListMap = {};
  prodListMap['subCategoryId'] = '$subCatId';
  if (cat == MainCategory.women) {
    prodListMap['mainCatId'] = '1';
  }
  if (cat == MainCategory.men) {
    prodListMap['mainCatId'] = '3';
  }
  if (cat == MainCategory.kids) {
    prodListMap['mainCatId'] = '2';
  }

  var response = await http.post(prodListUri, body: prodListMap);
  print(jsonDecode(response.body));

  List<ProductTileModel> list = [];
  var data = jsonDecode(response.body);
  data.forEach((prod) => {list.add(ProductTileModel.fromJson(prod))});
  print(list);
  return list;
}

Future<List<ProductTileModel>> getProductsListByUser(MainCategory cat, int subCatId) async {
  SharedPreferences prefs =  await SharedPreferences.getInstance();

  Map<String, String> prodListMap = {};
  prodListMap['subCategoryId'] = '$subCatId';
  if (cat == MainCategory.women) {
    prodListMap['mainCatId'] = '1';
  }
  if (cat == MainCategory.men) {
    prodListMap['mainCatId'] = '3';
  }
  if (cat == MainCategory.kids) {
    prodListMap['mainCatId'] = '2';
  }
  prodListMap['email'] = prefs.getString('userMail') ?? '';
  print ('map: $prodListMap');
  var response = await http.post(prodListUri, body: prodListMap);
  print(jsonDecode(response.body));

  List<ProductTileModel> list = [];
  var data = jsonDecode(response.body);
  data.forEach((prod) => {list.add(ProductTileModel.fromJson(prod))});
  print(list);
  return list;
}



Future<List<ProductTileModel>> getProductFromNewIn(MainCategory cat, int subCatId) async {
  SharedPreferences prefs =  await SharedPreferences.getInstance();

  Map<String, String> prodListMap = {};
  prodListMap['subCategoryId'] = '$subCatId';
  if (cat == MainCategory.women) {
    prodListMap['mainCatId'] = '1';
  }
  if (cat == MainCategory.men) {
    prodListMap['mainCatId'] = '3';
  }
  if (cat == MainCategory.kids) {
    prodListMap['mainCatId'] = '2';
  }
  prodListMap['email'] = prefs.getString('userMail') ?? '';
  print ('map: $prodListMap \nlink: $prodListNewInUri');
  var response = await http.post(prodListNewInUri, body: prodListMap);
  // print(jsonDecode(response.body));

  List<ProductTileModel> list = [];
  var data = jsonDecode(response.body);
  try {
    data.forEach((prod) => {list.add(ProductTileModel.fromJson(prod))});
  } catch (e) {
    print(e.toString());
  }
  print('list: $list');
  return list;
}

Future<SearchModel> searchProduct(text) async {
  Map<String, String> prodListMap = {};
  prodListMap['searchText'] = '$text';

  var response = await http.post(searchUri, body: prodListMap);

  SearchModel data = SearchModel.fromRawJson(response.body);

  return data;

}

