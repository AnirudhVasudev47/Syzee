// To parse this JSON data, do
//
//     final lookOfTheDayModel = lookOfTheDayModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class LookOfTheDayModel {
  LookOfTheDayModel({
    required this.data,
  });

  final List<Datum> data;

  factory LookOfTheDayModel.fromRawJson(String str) => LookOfTheDayModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LookOfTheDayModel.fromJson(Map<String, dynamic> json) => LookOfTheDayModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.image,
    required this.name,
    required this.price,
    required this.mainCatId,
    required this.prodId,
  });

  final String image;
  final String name;
  final int price;
  final int mainCatId;
  final String prodId;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    image: json["image"],
    name: json["name"],
    price: json["price"],
    mainCatId: json["mainCatId"],
    prodId: json["prodId"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "name": name,
    "price": price,
    "mainCatId": mainCatId,
    "prodId": prodId,
  };
}
