import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/wishlist_modal.dart';

Uri wishlist = Uri.parse('${AssetConstants.mockApiLink}/wishlist/user');
Uri prodUrl = Uri.parse('${AssetConstants.mockApiLink}/product/getId');
Uri addToWishUrl = Uri.parse('${AssetConstants.mockApiLink}/wishlist/user/add');
Uri removeFromWishUrl = Uri.parse('${AssetConstants.mockApiLink}/wishlist/user/remove');

Future<WishlistModal> getWishlist() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> prodMap = {};
  prodMap['email'] = prefs.getString('userMail') ?? '';

  final response = await http.post(wishlist, body: prodMap);
  print(response.body);
  return WishlistModal.fromRawJson(response.body);
}

Future<String> getProductId(mainCatId, id) async {

  Map<String, dynamic> prodMap = {};
  prodMap['mainCatId'] = mainCatId.toString();
  prodMap['id'] = id.toString();

  final response = await http.post(prodUrl, body: prodMap);

  return jsonDecode(response.body)['productId'];

}

addToWishlist (mainCatId, productId, size) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> prodMap = {};
  prodMap['email'] = prefs.getString('userMail') ?? '';
  prodMap['mainCatId'] = mainCatId.toString();
  prodMap['productId'] = productId.toString();
  prodMap['size'] = size.toString();

  final response = await http.post(addToWishUrl, body: prodMap);

  print (response.body);

  return ;
}

removeFromWishlist (mainCatId, productId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> prodMap = {};
  prodMap['email'] = prefs.getString('userMail') ?? '';
  prodMap['mainCatId'] = mainCatId.toString();
  prodMap['productId'] = productId.toString();

  final response = await http.post(removeFromWishUrl, body: prodMap);

  print (response.body);

  return ;
}