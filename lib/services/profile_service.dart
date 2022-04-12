import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:syzee/global/constants.dart';

Uri updateProfileUri = Uri.parse('${AssetConstants.mockApiLink}/user/update');

updateProfile(name, phone, code) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> prodMap = {};
  prodMap['name'] = '$name';
  prodMap['phone'] = '$phone';
  prodMap['code'] = '$code';
  prodMap['email'] = prefs.getString('userMail') ?? '';

  var res = await http.post(updateProfileUri, body: prodMap);
  print(res.body);
  return jsonDecode(res.body);
}