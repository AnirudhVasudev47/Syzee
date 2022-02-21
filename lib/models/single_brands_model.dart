// To parse this JSON data, do
//
//     final singleBrandsModel = singleBrandsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class SingleBrandsModel {
  SingleBrandsModel({
    required this.data,
  });

  final List<Datum> data;

  factory SingleBrandsModel.fromRawJson(String str) => SingleBrandsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SingleBrandsModel.fromJson(Map<String, dynamic> json) => SingleBrandsModel(
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
    required this.image,
    required this.price,
    required this.brand,
    required this.wishlist,
    required this.mainCatId,
  });

  final String id;
  final String name;
  final String image;
  final int price;
  final String brand;
  final bool wishlist;
  final int mainCatId;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    price: json["price"],
    brand: json["brand"],
    wishlist: json["wishlist"],
    mainCatId: json["mainCatId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "price": price,
    "brand": brand,
    "wishlist": wishlist,
    "mainCatId": mainCatId,
  };
}
