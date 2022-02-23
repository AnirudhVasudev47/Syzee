import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/brands_model.dart';
import 'package:syzee/models/look_of_the_day_model.dart';
import 'package:syzee/models/week_highlights_model.dart';

Uri banner = Uri.parse('${AssetConstants.mockApiLink}/home_tab/banner');
Uri categories = Uri.parse('${AssetConstants.mockApiLink}/home_tab/category');
Uri brands = Uri.parse('${AssetConstants.mockApiLink}/home_tab/brands');
Uri lookOfTheDay = Uri.parse('${AssetConstants.mockApiLink}/home_tab/lookOfTheDay');
Uri weekHighlights = Uri.parse('${AssetConstants.mockApiLink}/home_tab/weekshighlights');

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
  // print(jsonDecode(res.body));
  for (int i=0; i<jsonDecode(res.body).length; i++) {
    Map<String, dynamic> item = {};
    item['image'] = '${AssetConstants.mockImageLink}/product_images/${jsonDecode(res.body)[i]['image']}';
    item['text'] = jsonDecode(res.body)[i]['heading'];
    dataList.add(item);
  }
  // print(dataList);
  return dataList;
}

Future<BrandsModel> getHomeTabBrands() async {

  final response = await http.get(brands);

  return BrandsModel.fromRawJson(response.body);

}

Future<LookOfTheDayModel> getLookOfTheDay() async {

  final response = await http.get(lookOfTheDay);

  return LookOfTheDayModel.fromRawJson(response.body);

}

Future<WeekHighlightsModel> getWeekHighlights() async {

  final response = await http.get(weekHighlights);
  
  print(response.body);

  return WeekHighlightsModel.fromRawJson(response.body);

}

