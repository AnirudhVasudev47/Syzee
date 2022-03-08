// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class SearchModel {
  SearchModel({
    required this.data,
  });

  final Data data;

  factory SearchModel.fromRawJson(String str) => SearchModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.womenSearch,
    required this.kidsSearch,
  });

  final List<Search> womenSearch;
  final List<Search> kidsSearch;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    womenSearch: List<Search>.from(json["womenSearch"].map((x) => Search.fromJson(x))),
    kidsSearch: List<Search>.from(json["kidsSearch"].map((x) => Search.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "womenSearch": List<dynamic>.from(womenSearch.map((x) => x.toJson())),
    "kidsSearch": List<dynamic>.from(kidsSearch.map((x) => x.toJson())),
  };
}

class Search {
  Search({
    required this.name,
    required this.mainCatId,
    required this.productId,
  });

  final String name;
  final int mainCatId;
  final String productId;

  factory Search.fromRawJson(String str) => Search.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Search.fromJson(Map<String, dynamic> json) => Search(
    name: json["name"],
    mainCatId: json["mainCatId"],
    productId: json["productId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mainCatId": mainCatId,
    "productId": productId,
  };
}
