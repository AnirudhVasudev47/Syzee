import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/sizing_profile_model.dart';

Uri getAllSizeUri = Uri.parse('${AssetConstants.mockApiLink}/user/get/sizingProfile');
Uri updateSizeUri = Uri.parse('${AssetConstants.mockApiLink}/user/update/sizingProfile');
Uri updateDefaultSizeUri = Uri.parse('${AssetConstants.mockApiLink}/user/update/default/sizingProfile');
Uri addSizeUri = Uri.parse('${AssetConstants.mockApiLink}/user/add/sizingProfile');
String delSizeUri = '${AssetConstants.mockApiLink}/user/delete/sizingProfile';

Future<SizingProfileModel> getAllSizingProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> prodMap = {};
  prodMap['email'] = prefs.getString('userMail') ?? '';

  var res = await http.post(getAllSizeUri, body: prodMap);

  return SizingProfileModel.fromRawJson(res.body);
}

updateSizingProfile(
  height,
  heightUnits,
  weight,
  weightUnits,
  upperBody,
  lowerBody,
  length,
  width,
  chest,
  sleevesFromNeck,
  waist,
  waistFormNeck,
  chestFromNeck,
  hips,
  id,
) async {
  Map<String, dynamic> prodMap = {};
  prodMap['height'] = height.toString();
  prodMap['heightUnits'] = heightUnits.toString();
  prodMap['weight'] = weight.toString();
  prodMap['weightUnits'] = weightUnits.toString();
  prodMap['upperBody'] = upperBody.toString();
  prodMap['lowerBody'] = lowerBody.toString();
  prodMap['length'] = length.toString();
  prodMap['width'] = width.toString();
  prodMap['chest'] = chest.toString();
  prodMap['sleevesFromNeck'] = sleevesFromNeck.toString();
  prodMap['waist'] = waist.toString();
  prodMap['waistFormNeck'] = waistFormNeck.toString();
  prodMap['chestFromNeck'] = chestFromNeck.toString();
  prodMap['hips'] = hips.toString();
  prodMap['id'] = id.toString();

  var res = await http.post(updateSizeUri, body: prodMap);

  return;
}

addSizingProfile(
  height,
  heightUnits,
  weight,
  weightUnits,
  upperBody,
  lowerBody,
  length,
  width,
  chest,
  sleevesFromNeck,
  waist,
  waistFormNeck,
  chestFromNeck,
  hips,
) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> prodMap = {};
  prodMap['height'] = height.toString();
  prodMap['heightUnits'] = heightUnits.toString();
  prodMap['weight'] = weight.toString();
  prodMap['weightUnits'] = weightUnits.toString();
  prodMap['upperBody'] = upperBody.toString();
  prodMap['lowerBody'] = lowerBody.toString();
  prodMap['length'] = length.toString();
  prodMap['width'] = width.toString();
  prodMap['chest'] = chest.toString();
  prodMap['sleevesFromNeck'] = sleevesFromNeck.toString();
  prodMap['waist'] = waist.toString();
  prodMap['waistFormNeck'] = waistFormNeck.toString();
  prodMap['chestFromNeck'] = chestFromNeck.toString();
  prodMap['hips'] = hips.toString();
  prodMap['email'] = prefs.getString('userMail') ?? '';

  var res = await http.post(addSizeUri, body: prodMap);

  print(res.body);

  return;
}

deleteSizingProfile(id) async {
  var res = await http.delete(Uri.parse('$delSizeUri/$id'));

  print(res.body);

  return;
}

updateDefaultSizingProfile(id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> prodMap = {};
  prodMap['id'] = id.toString();
  prodMap['email'] = prefs.getString('userMail') ?? '';

  var res = await http.post(updateDefaultSizeUri, body: prodMap);

  print(res.body);

  return;
}
