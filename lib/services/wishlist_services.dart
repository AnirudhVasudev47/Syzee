import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/wishlist_modal.dart';

Uri wishlist = Uri.parse('${AssetConstants.mockApiLink}/wishlist/user');
Uri prodUrl = Uri.parse('${AssetConstants.mockApiLink}/product/getId');

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