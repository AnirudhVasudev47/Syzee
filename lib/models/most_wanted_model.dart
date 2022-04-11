// To parse this JSON data, do
//
//     final mostWantedModel = mostWantedModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class MostWantedModel {
  MostWantedModel({
    required this.data,
  });

  final List<Datum> data;

  factory MostWantedModel.fromRawJson(String str) => MostWantedModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MostWantedModel.fromJson(Map<String, dynamic> json) => MostWantedModel(
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
    required this.heading,
    required this.categoryId,
    required this.subCategoryId,
    required this.mainCategoryId,
    required this.createdOn,
    required this.createdBy,
    required this.resetOn,
    required this.resetBy,
    required this.status,
  });

  final int id;
  final String image;
  final String heading;
  final String categoryId;
  final String subCategoryId;
  final String mainCategoryId;
  final DateTime createdOn;
  final String createdBy;
  final String resetOn;
  final String resetBy;
  final int status;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"],
    image: json["IMAGE"],
    heading: json["HEADING"],
    categoryId: json["CATEGORY_ID"],
    subCategoryId: json["SUB_CATEGORY_ID"],
    mainCategoryId: json["MAIN_CATEGORY_ID"],
    createdOn: DateTime.parse(json["CREATED_ON"]),
    createdBy: json["CREATED_BY"] ?? '',
    resetOn: json["RESET_ON"],
    resetBy: json["RESET_BY"] ?? '',
    status: json["STATUS"] ?? 1,
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "IMAGE": image,
    "HEADING": heading,
    "CATEGORY_ID": categoryId,
    "SUB_CATEGORY_ID": subCategoryId,
    "MAIN_CATEGORY_ID": mainCategoryId,
    "CREATED_ON": createdOn.toIso8601String(),
    "CREATED_BY": createdBy,
    "RESET_ON": resetOn,
    "RESET_BY": resetBy,
    "STATUS": status,
  };
}
