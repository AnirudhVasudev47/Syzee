import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/product.dart';
import 'package:syzee/models/product_list_model.dart';
import 'package:syzee/models/review_model.dart';
import 'package:syzee/models/size_chart_model.dart';

getProductService(String id, MainCategory cat) async {
  Uri productUri = Uri.parse('${AssetConstants.mockApiLink}/id/product');

  Map<String, dynamic> prodMap = {};

  prodMap['productStyle'] = id;
  if (cat == MainCategory.women) {
    prodMap['mainCatId'] = '1';
  }
  if (cat == MainCategory.men) {
    prodMap['mainCatId'] = '3';
  }
  if (cat == MainCategory.kids) {
    prodMap['mainCatId'] = '2';
  }

  var res = await http.post(productUri, body: prodMap);
  print('product info: ' + res.body);
  print(prodMap);

  var response = jsonDecode(res.body);

  print('data: ${response['data']}');

  if (response['data'] == null) {
    return Product.fromRawJson(res.body);
  } else {
    return 'no/Product';
  }
}

Future<SizeChartModel> getProductSizeChart(String id, MainCategory cat) async {
  Uri productUri = Uri.parse('${AssetConstants.mockApiLink}/product/table');

  Map<String, dynamic> prodMap = {};

  prodMap['productId'] = id;
  if (cat == MainCategory.women) {
    prodMap['mainCatId'] = '1';
  }
  if (cat == MainCategory.men) {
    prodMap['mainCatId'] = '3';
  }
  if (cat == MainCategory.kids) {
    prodMap['mainCatId'] = '2';
  }

  print('response' + prodMap.toString());

  var res = await http.post(productUri, body: prodMap);

  print('status: ' + res.statusCode.toString());
  print('size info: ' + res.body);
  return SizeChartModel.fromRawJson(res.body);
}

Future<List<ProductTileModel>> getCompleteLook(MainCategory cat, String style, String sellerId) async {
  Uri completeUri = Uri.parse('${AssetConstants.mockApiLink}/product/complete_look');
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, String> prodListMap = {};
  prodListMap['productStyle'] = style;
  prodListMap['sellerId'] = sellerId;

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
  // print ('map: $prodListMap \nlink: $prodListNewInUri');
  var response = await http.post(completeUri, body: prodListMap);
  // print(jsonDecode(response.body));

  List<ProductTileModel> list = [];
  var data = jsonDecode(response.body);
  // print('all clothing: ${response.body}');
  try {
    data.forEach((prod) => {list.add(ProductTileModel.fromJson(prod))});
  } catch (e) {
    // print(e.toString());
  }
  // print('list: $list');
  return list;
}

Future<ReviewModel> getProductReviews (id, cat) async {
  Uri prodReview = Uri.parse('${AssetConstants.mockApiLink}/product/review');

  Map<String, String> prodListMap = {};
  prodListMap['productId'] = id.toString();

  if (cat == MainCategory.women) {
    prodListMap['mainCatId'] = '1';
  }
  if (cat == MainCategory.men) {
    prodListMap['mainCatId'] = '3';
  }
  if (cat == MainCategory.kids) {
    prodListMap['mainCatId'] = '2';
  }
  print('review post: $prodListMap');
  var response = await http.post(prodReview, body: prodListMap);  
  print ('review data: '+ response.body);
  ReviewModel rev = ReviewModel.fromRawJson(response.body);
  return rev;
}