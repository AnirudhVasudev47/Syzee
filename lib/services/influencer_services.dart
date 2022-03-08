

import 'package:http/http.dart' as http;
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/influencer_list_model.dart';
import 'package:syzee/models/influencer_story_model.dart';

Uri listUri = Uri.parse('${AssetConstants.mockApiLink}/influencer/list');
String storyUri = '${AssetConstants.mockApiLink}/influencer/stories';


Future<InfluencerList> getListOfInfluencer () async {
  final response = await http.get(listUri);

  return InfluencerList.fromRawJson(response.body);
}

Future<InfluencerStoryModel> getInfluencerStory(var id) async {

  final res = await http.get(Uri.parse('$storyUri/$id'));

  return InfluencerStoryModel.fromRawJson(res.body);
}