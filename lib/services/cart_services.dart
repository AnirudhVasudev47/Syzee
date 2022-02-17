import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/cart_model.dart';
import 'package:syzee/models/coupon_list_model.dart';
import 'package:syzee/models/user_model.dart';

Uri addToCartUri = Uri.parse('${AssetConstants.mockApiLink}/cart/add');
Uri fetchCartUri = Uri.parse('${AssetConstants.mockApiLink}/cart/getByUserId');
Uri fetchCouponUri =
    Uri.parse('${AssetConstants.mockApiLink}/coupon/getCoupons');
Uri deleteCartUri = Uri.parse('${AssetConstants.mockApiLink}/cart/deleteById');
Uri getCouponsUri =
    Uri.parse('${AssetConstants.mockApiLink}/coupon/getCoupons');
Uri updateCartUri =
    Uri.parse('${AssetConstants.mockApiLink}/cart/setCartQuantity');
Uri getUserUri =
    Uri.parse('${AssetConstants.mockApiLink}/user/fetchDetails');

Future<dynamic> addToCart(
    MainCategory cat, String productId, String size, String email) async {
  Map<String, dynamic> prodMap = {};

  prodMap['productId'] = productId;
  prodMap['size'] = size;
  prodMap['email'] = email;
  if (cat == MainCategory.women) {
    prodMap['mainCatId'] = '1';
  }
  if (cat == MainCategory.men) {
    prodMap['mainCatId'] = '3';
  }
  if (cat == MainCategory.kids) {
    prodMap['mainCatId'] = '2';
  }

  var res = await http.post(addToCartUri, body: prodMap);

  var data = jsonDecode(res.body);

  if (data['data'] == 'success') {
    print('done');
    return true;
  } else {
    print('done');
    return false;
  }
}

Future<CartModel> fetchCartByEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> prodMap = {};
  prodMap['email'] = prefs.getString('userMail') ?? '';
  print('map: $prodMap');
  var res = await http.post(fetchCartUri, body: prodMap);
  print(res.body);
  CartModel data = CartModel.fromRawJson(res.body);
  print('cart: $data');
  return data;
}

Future<CartModel?> fetchAllCoupon() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> prodMap = {};
  prodMap['email'] = prefs.getString('userMail') ?? '';
  print('map: $prodMap');
  var res = await http.post(fetchCartUri, body: prodMap);
  print(res.body);
  CartModel data = CartModel.fromRawJson(res.body);
  print('cart: $data');
  return data;
}

Future deleteFromCart(id, size) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> prodMap = {};
  prodMap['id'] = '$id';
  prodMap['size'] = '$size';
  prodMap['email'] = prefs.getString('userMail') ?? '';
  print('id: $id \nsize: $size');
  var res = await http.delete(deleteCartUri, body: prodMap);
  print('delete response: ${jsonDecode(res.body)}');
  return jsonDecode(res.body);
}

Future<CouponListModel> getCouponList() async {
  var res = await http.get(getCouponsUri);

  CouponListModel coupons = CouponListModel.fromRawJson(res.body);

  print(coupons);
  return coupons;
}

updateCart(productId, size, quantity) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> prodMap = {};
  prodMap['productId'] = '$productId';
  prodMap['size'] = '$size';
  prodMap['quantity'] = '$quantity';
  prodMap['email'] = prefs.getString('userMail') ?? '';

  var res = await http.post(updateCartUri, body: prodMap);
  print(res.body);
  return jsonDecode(res.body);
}

Future<UserModel> getUserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> prodMap = {};
  prodMap['email'] = prefs.getString('userMail') ?? '';

  var res = await http.post(getUserUri, body: prodMap);

  UserModel user = UserModel.fromRawJson(res.body);

  prefs.setString('userPhone', user.phone.toString());
  prefs.setString('userId', user.id.toString());
  prefs.setString('userCode', user.code.toString());
  prefs.setString('userName', user.name.toString());

  return user;
}