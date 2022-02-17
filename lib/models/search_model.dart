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

  final List<String> womenSearch;
  final List<String> kidsSearch;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    womenSearch: List<String>.from(json["womenSearch"].map((x) => x)),
    kidsSearch: List<String>.from(json["kidsSearch"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "womenSearch": List<dynamic>.from(womenSearch.map((x) => x)),
    "kidsSearch": List<dynamic>.from(kidsSearch.map((x) => x)),
  };
}
