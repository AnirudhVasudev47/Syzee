// To parse this JSON data, do
//
//     final productTileModel = productTileModelFromJson(jsonString);

import 'dart:convert';

class ProductTileModel {
  ProductTileModel({
    required this.productId,
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.createdOn,
    required this.rating,
    required this.color,
    required this.brand,
    required this.wishlist,
    required this.size,
  });

  final int productId;
  final String id;
  final String name;
  final String image;
  final int price;
  final DateTime createdOn;
  final String rating;
  final String color;
  final String brand;
  final bool wishlist;
  final String size;

  factory ProductTileModel.fromRawJson(String str) => ProductTileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductTileModel.fromJson(Map<String, dynamic> json) => ProductTileModel(
    productId: json["productId"],
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        createdOn: DateTime.parse(json["created_on"]),
        rating: json["rating"] ?? 0,
        color: json["color"],
        brand: json["brand"] ?? ' ',
        wishlist: json["wishlist"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() =>
      {
        "productId": productId,
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "created_on": createdOn.toIso8601String(),
        "rating": rating == null ? null : rating,
        "color": color,
        "brand": brand == null ? null : brand,
        "wishlist": wishlist,
        "size": size,
      };
}
