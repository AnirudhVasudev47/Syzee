import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:syzee/global/constants.dart';

Uri banner = Uri.parse('${AssetConstants.mockApiLink}/home_tab/banner');
Uri categories = Uri.parse('${AssetConstants.mockApiLink}/home_tab/category');
Uri brands = Uri.parse('${AssetConstants.mockApiLink}/home_tab/brands');

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

Future<List<String>> getHomeTabBrands() async {

  List<String> imageList = [];
  print(brands);
  final response = await http.get(brands);
  print(jsonDecode(response.body).length);
  for (int i=0; i<jsonDecode(response.body).length; i++) {
    imageList.add('${AssetConstants.mockImageLink}/BRANDS/${jsonDecode(response.body)[i]['IMAGE']}');
  }
  return imageList;

}