

import 'package:http/http.dart' as http;
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/influencer_list_model.dart';

Uri listUri = Uri.parse('${AssetConstants.mockApiLink}/influencer/list');


Future<InfluencerList> getListOfInfluencer () async {
  final response = await http.get(listUri);

  return InfluencerList.fromRawJson(response.body);
}