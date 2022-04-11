import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/brands_model.dart';
import 'package:syzee/models/look_of_the_day_model.dart';
import 'package:syzee/models/most_wanted_model.dart';
import 'package:syzee/models/week_highlights_model.dart';
import 'package:syzee/ui/widgets/home_tab_most_wanted.dart';

Uri banner = Uri.parse('${AssetConstants.mockApiLink}/home_tab/banner');
Uri categories = Uri.parse('${AssetConstants.mockApiLink}/home_tab/category');
Uri brands = Uri.parse('${AssetConstants.mockApiLink}/home_tab/brands');
Uri lookOfTheDay = Uri.parse('${AssetConstants.mockApiLink}/home_tab/lookOfTheDay');
Uri weekHighlights = Uri.parse('${AssetConstants.mockApiLink}/home_tab/weekshighlights');
Uri mostWanted = Uri.parse('${AssetConstants.mockApiLink}/home_tab/mostwanted');

Future<List<String>> getBanner() async {
  List<String> imageList = [];
  final response = await http.get(banner);
  // print(jsonDecode(response.body));
  for (int i=0; i<jsonDecode(response.body).length; i++) {
    imageList.add('${AssetConstants.mockImageLink}/revolution_layer_slider_demo_6/${jsonDecode(response.body)[i]['BANNER_IMAGE']}');
    // print('https://saraiexim.net/syzee/images/revolution_layer_slider_demo_6/${jsonDecode(response.body)[i]['BANNER_IMAGE']}');
  }
  return imageList;
}

Future<List<Map<String, dynamic>>> getHomeCategories() async {
  List<Map<String, dynamic>> dataList = [];

  final res = await http.get(categories);
  print(jsonDecode(res.body));
  for (int i=0; i<jsonDecode(res.body).length; i++) {
    Map<String, dynamic> item = {};
    item['image'] = '${AssetConstants.mockImageLink}/product_images/${jsonDecode(res.body)[i]['image']}';
    item['text'] = jsonDecode(res.body)[i]['heading'];
    item['mainCatId'] = jsonDecode(res.body)[i]['mainCatId'];
    item['subCatId'] = jsonDecode(res.body)[i]['subCatId'];
    dataList.add(item);
  }
  return dataList;
}

Future<BrandsModel> getHomeTabBrands() async {

  final response = await http.get(brands);
  // print(response.body.toString());
  return BrandsModel.fromRawJson(response.body);

}

Future<LookOfTheDayModel> getLookOfTheDay() async {

  final response = await http.get(lookOfTheDay);

  return LookOfTheDayModel.fromRawJson(response.body);

}

Future<WeekHighlightsModel> getWeekHighlights() async {

  final response = await http.get(weekHighlights);
  
  // print(response.body);

  return WeekHighlightsModel.fromRawJson(response.body);

}

Future<MostWantedModel> getMostWanted() async {

  final response = await http.get(mostWanted);

  return MostWantedModel.fromRawJson(response.body);

}