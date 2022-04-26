import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/order_list_model.dart';
import 'package:syzee/models/order_product_details.dart';
import 'package:syzee/models/pending_order_model.dart';
import 'package:syzee/models/user_model.dart';
import 'package:syzee/services/cart_services.dart';

Uri prodDetails = Uri.parse('${AssetConstants.mockApiLink}/history/order/details');
Uri orderList = Uri.parse('${AssetConstants.mockApiLink}/order/user/history');
Uri pendingOrderList = Uri.parse('${AssetConstants.mockApiLink}/order/user/pending/history');
Uri updateDelivery = Uri.parse('${AssetConstants.mockApiLink}/order/setDelivery');
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

Future<PendingOrderModel> getPendingOrderList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> prodMap = {};
  prodMap['email'] = prefs.getString('userMail') ?? '';

  var res = await http.post(pendingOrderList, body: prodMap);

  return PendingOrderModel.fromRawJson(res.body);
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

  print(res.body);

  return res.body;
}

getPaymentGateway() async {
  var payUri = Uri.parse('https://paymentapi.qib.com.qa/api/gateway/v2.0');

  Map<String, String> headersMap = {};
  headersMap['Content-Type'] = 'application/x-www-form-urlencoded';

  Map<String, dynamic> prodMap = {};
  prodMap['action'] = 'CAPTURE';
  prodMap['gatewayId'] = '011997315';
  prodMap['signatureFields'] = 'gatewayId,amount,referenceId';
  prodMap['signature'] = '1JfeYpjWLfbC8cGBcVQmfTDVxyT1hBE222E6hKIwITQ=';
  prodMap['referenceId'] = '12345678908';
  prodMap['amount'] = '50.00';
  prodMap['currency'] = 'QAR';
  prodMap['mode'] = 'test';
  prodMap['description'] = 'qpay pament';
  prodMap['returnUrl'] = 'https://syzee.co/';
  prodMap['name'] = 'full name';
  prodMap['address'] = 'dOHA';
  prodMap['city'] = 'Doha';
  prodMap['state'] = 'Doha';
  prodMap['country'] = 'QA';
  prodMap['phone'] = '9741234561';
  prodMap['email'] = 'prajna@gmail.com';

  var res = await http.post(payUri, body: prodMap, headers: headersMap, encoding: Encoding.getByName('utf-8'));

  print(res.body);

  return res.body.toString();
}

updateDeliveryDate(orderId, delDate) async {
  Map<String, dynamic> prodMap = {};
  prodMap['orderId'] = orderId;
  prodMap['date'] = delDate;

  var res = await http.post(updateDelivery, body: prodMap);

  return res.body;
}
