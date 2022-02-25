// To parse this JSON data, do
//
//     final wishlistModal = wishlistModalFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class WishlistModal {
  WishlistModal({
    required this.data,
  });

  final List<Datum> data;

  factory WishlistModal.fromRawJson(String str) => WishlistModal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WishlistModal.fromJson(Map<String, dynamic> json) => WishlistModal(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.mainCatId,
    required this.productId,
    required this.image,
    required this.productName,
    required this.tagLine,
    required this.wishlist,
    required this.price,
  });

  final int mainCatId;
  final int productId;
  final String image;
  final String productName;
  final String tagLine;
  final bool wishlist;
  final int price;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    mainCatId: json["mainCatId"],
    productId: json["productId"],
    image: json["image"],
    productName: json["productName"],
    tagLine: json["tagLine"],
    wishlist: json["wishlist"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "mainCatId": mainCatId,
    "productId": productId,
    "image": image,
    "productName": productName,
    "tagLine": tagLine,
    "wishlist": wishlist,
    "price": price,
  };
}
