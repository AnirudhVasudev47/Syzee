import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/order_list_model.dart';
import 'package:syzee/models/order_product_details.dart';
import 'package:syzee/models/user_model.dart';
import 'package:syzee/services/cart_services.dart';

Uri prodDetails = Uri.parse('${AssetConstants.mockApiLink}/history/order/details');
Uri orderList = Uri.parse('${AssetConstants.mockApiLink}/order/user/history');
Uri placeOrderUrl = Uri.parse('${AssetConstants.mockApiLink}/order/place/order');

Future<OrderProductDetails> getProdDetails(String id, String cat) async {
  Map<String, dynamic> prodMap = {};

  prodMap['prodId'] = id;
  prodMap['mainCatId'] = cat;

  var res = await http.post(prodDetails, body: prodMap);

  return OrderProductDetails.fromRawJson(res.body);
}

Future<OrderListModel> getOrderList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> prodMap = {};
  prodMap['email'] = prefs.getString('userMail') ?? '';

  var res = await http.post(orderList, body: prodMap);

  return OrderListModel.fromRawJson(res.body);
}

Future<String> placeOrder(
  address,
  country,
  state,
  city,
  postalCode,
  addressType,
  total,
  coupon,
  points,
  grandTotal,
  paymentStatus,
  paymentId,
  couponDetails,
) async {
  UserModel user = await getUserInfo();

  Map<String, dynamic> prodMap = {};
  prodMap['email'] = user.email;
  prodMap['userName'] = user.name;
  prodMap['mobile'] = '${user.code} ${user.phone}';
  prodMap['address'] = address.toString();
  prodMap['country'] = country.toString();
  prodMap['state'] = state.toString();
  prodMap['city'] = city.toString();
  prodMap['postalCode'] = postalCode.toString();
  prodMap['addressType'] = addressType.toString();
  prodMap['total'] = total.toString();
  prodMap['coupon'] = coupon.toString();
  prodMap['points'] = points.toString();
  prodMap['grandTotal'] = grandTotal.toString();
  prodMap['paymentStatus'] = paymentStatus.toString();
  prodMap['paymentId'] = paymentId.toString();
  prodMap['couponDetails'] = couponDetails.toString();

  var res = await http.post(placeOrderUrl, body: prodMap);

  print (res.body);

  return res.body;

}
