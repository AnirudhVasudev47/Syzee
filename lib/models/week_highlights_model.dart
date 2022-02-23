// To parse this JSON data, do
//
//     final weekHighlightsModel = weekHighlightsModelFromJson(jsonString);

import 'dart:convert';

class WeekHighlightsModel {
  WeekHighlightsModel({
    required this.data,
  });

  final List<Datum> data;

  factory WeekHighlightsModel.fromRawJson(String str) => WeekHighlightsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WeekHighlightsModel.fromJson(Map<String, dynamic> json) => WeekHighlightsModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.mainCatId,
    required this.productId,
    required this.addedOn,
    required this.addedBy,
  });

  final int id;
  final String image;
  final String title;
  final String description;
  final String mainCatId;
  final String productId;
  final DateTime addedOn;
  final String addedBy;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"],
    image: json["IMAGE"],
    title: json["TITLE"],
    description: json["DESCRIPTION"],
    mainCatId: json["MAIN_CAT_ID"],
    productId: json["PRODUCT_ID"],
    addedOn: DateTime.parse(json["ADDED_ON"]),
    addedBy: json["ADDED_BY"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "IMAGE": image,
    "TITLE": title,
    "DESCRIPTION": description,
    "MAIN_CAT_ID": mainCatId,
    "PRODUCT_ID": productId,
    "ADDED_ON": addedOn.toIso8601String(),
    "ADDED_BY": addedBy,
  };
}
