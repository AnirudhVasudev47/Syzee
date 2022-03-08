// To parse this JSON data, do
//
//     final orderProductDetails = orderProductDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class OrderProductDetails {
  OrderProductDetails({
    required this.image,
    required this.name,
    required this.prodId,
  });

  final String image;
  final String name;
  final String prodId;

  factory OrderProductDetails.fromRawJson(String str) => OrderProductDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderProductDetails.fromJson(Map<String, dynamic> json) => OrderProductDetails(
    image: json["image"],
    name: json["name"],
    prodId: json["prodId"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "name": name,
    "prodId": prodId,
  };
}
