import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/sizing_profile_model.dart';

Uri getAllSizeUri = Uri.parse('${AssetConstants.mockApiLink}/user/get/sizingProfile');

Future<SizingProfileModel> getAllSizingProfile () async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> prodMap = {};
  prodMap['email'] = prefs.getString('userMail') ?? '';

  var res = await http.post(getAllSizeUri, body: prodMap);

  return SizingProfileModel.fromRawJson(res.body);
}