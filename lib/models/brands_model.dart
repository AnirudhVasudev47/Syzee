// To parse this JSON data, do
//
//     final brandsModel = brandsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class BrandsModel {
  BrandsModel({
    required this.data,
  });

  final List<Datum> data;

  factory BrandsModel.fromRawJson(String str) => BrandsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BrandsModel.fromJson(Map<String, dynamic> json) => BrandsModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.imageCarousel,
    required this.status,
    required this.createdOn,
    required this.createdBy,
    required this.resetOn,
  });

  final int id;
  final String name;
  final dynamic description;
  final String image;
  final String imageCarousel;
  final int status;
  final DateTime createdOn;
  final dynamic createdBy;
  final dynamic resetOn;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"],
    name: json["NAME"],
    description: json["DESCRIPTION"],
    image: json["IMAGE"],
    imageCarousel: json["IMAGE_CAROUSEL"],
    status: json["STATUS"],
    createdOn: DateTime.parse(json["CREATED_ON"]),
    createdBy: json["CREATED_BY"],
    resetOn: json["RESET_ON"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "NAME": name,
    "DESCRIPTION": description,
    "IMAGE": image,
    "IMAGE_CAROUSEL": imageCarousel,
    "STATUS": status,
    "CREATED_ON": createdOn.toIso8601String(),
    "CREATED_BY": createdBy,
    "RESET_ON": resetOn,
  };
}
