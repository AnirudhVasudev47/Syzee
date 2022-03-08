
import 'package:http/http.dart' as http;
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/product.dart';

Future<Product> getProductService(String id, MainCategory cat) async {
  Uri productUri = Uri.parse('${AssetConstants.mockApiLink}/id/product');

  Map<String, dynamic> prodMap = {};

  prodMap['productStyle'] = id;
  if (cat == MainCategory.women) {
    prodMap['mainCatId'] = '1';
  }
  if (cat == MainCategory.men) {
    prodMap['mainCatId'] = '3';
  }
  if (cat == MainCategory.kids) {
    prodMap['mainCatId'] = '2';
  }

  var res = await http.post(productUri, body: prodMap);
  print('product info: ' + res.body);
  print(prodMap);
  return Product.fromRawJson(res.body);
}
