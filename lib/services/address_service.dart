import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/address_model.dart';

Uri getAddressUri = Uri.parse('${AssetConstants.mockApiLink}/user/get/address');
Uri updateAddressUri = Uri.parse('${AssetConstants.mockApiLink}/user/update/address');
Uri addAddressUri = Uri.parse('${AssetConstants.mockApiLink}/user/add/address');
Uri deleteAddressUri = Uri.parse('${AssetConstants.mockApiLink}/user/delete/address');

Future<AddressModel> getAddress() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> prodMap = {};
  prodMap['email'] = prefs.getString('userMail') ?? '';

  var res = await http.post(getAddressUri, body: prodMap);

  AddressModel address = AddressModel.fromRawJson(res.body);

  return address;
}

Future<dynamic> addAddress(name, code, phone, doorNo, buildingNo, street, zone, country, addType) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> prodMap = {};
  prodMap['email'] = prefs.getString('userMail') ?? '';
  prodMap['name'] = name;
  prodMap['code'] = code;
  prodMap['phone'] = phone;
  prodMap['doorNo'] = doorNo;
  prodMap['buildingNo'] = buildingNo;
  prodMap['street'] = street;
  prodMap['zone'] = zone;
  prodMap['country'] = country;
  prodMap['addType'] = addType;

  var res = await http.post(addAddressUri, body: prodMap);

  return jsonDecode(res.body);
}

Future<dynamic> updateAddress(id, name, code, phone, doorNo, buildingNo, street, zone, country, addType) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> prodMap = {};
  prodMap['id'] = id;
  prodMap['name'] = name;
  prodMap['code'] = code;
  prodMap['phone'] = phone;
  prodMap['doorNo'] = doorNo;
  prodMap['buildingNo'] = buildingNo;
  prodMap['street'] = street;
  prodMap['zone'] = zone;
  prodMap['country'] = country;
  prodMap['addType'] = addType;

  var res = await http.post(addAddressUri, body: prodMap);

  return jsonDecode(res.body);
}

deleteAddress (id) async {
  Map<String, dynamic> prodMap = {};
  prodMap['id'] = '$id';
  var res = await http.delete(deleteAddressUri, body: prodMap);

  return jsonDecode(res.body);
}