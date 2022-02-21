import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/brands_model.dart';
import 'package:syzee/models/single_brands_model.dart';

Uri banner = Uri.parse('${AssetConstants.mockApiLink}/brands/list/all');
String brandProduct = '${AssetConstants.mockApiLink}/brands/product';

Future<BrandsModel> getAllBrands() async {
  final response = await http.get(banner);

  return BrandsModel.fromRawJson(response.body);
}

Future<SingleBrandsModel> getBrandsProducts (id) async {
  final response = await http.get(Uri.parse('$brandProduct/$id'));

  print(response.body);
  
  return SingleBrandsModel.fromRawJson(response.body);
}