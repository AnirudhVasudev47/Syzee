// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CartModel {
  CartModel({
    required this.data,
  });

  final Data data;

  factory CartModel.fromRawJson(String str) => CartModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.cart,
    required this.noOfItems,
    required this.total,
  });

  final List<Cart> cart;
  final int noOfItems;
  final int total;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
    noOfItems: json["noOfItems"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
    "noOfItems": noOfItems,
    "total": total,
  };
}

class Cart {
  Cart({
    required this.name,
    required this.id,
    required this.mainId,
    required this.tagLine,
    required this.size,
    required this.quantity,
    required this.image,
    required this.price,
  });

  final String name;
  final int id;
  final int mainId;
  final String tagLine;
  final String size;
  final int quantity;
  final String image;
  final String price;

  factory Cart.fromRawJson(String str) => Cart.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    name: json["name"],
    id: json["id"],
    mainId: json["mainId"],
    tagLine: json["tagLine"],
    size: json["size"],
    quantity: json["quantity"],
    image: json["image"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "mainId": mainId,
    "tagLine": tagLine,
    "size": size,
    "quantity": quantity,
    "image": image,
    "price": price,
  };
}
