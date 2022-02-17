// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

class Product {
  Product({
    required this.name,
    required this.brand,
    required this.sellerId,
    required this.productId,
    required this.tagLine,
    required this.description,
    required this.variants,
  });

  final String name;
  final String brand;
  final String sellerId;
  final String productId;
  final String tagLine;
  final String description;
  final List<Variant> variants;

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    name: json["name"],
    brand: json["brand"],
    sellerId: json["sellerId"],
    productId: json["productId"],
    tagLine: json["tagLine"],
    description: json["description"],
    variants: List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "brand": brand,
    "sellerId": sellerId,
    "productId": productId,
    "tagLine": tagLine,
    "description": description,
    "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
  };
}

class Variant {
  Variant({
    required this.id,
    required this.color,
    required this.colorName,
    required this.images,
    required this.sizeVariants,
  });

  final int id;
  final String color;
  final String colorName;
  final List<String> images;
  final List<SizeVariant> sizeVariants;

  factory Variant.fromRawJson(String str) => Variant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    id: json["id"],
    color: json["color"],
    colorName: json["colorName"],
    images: List<String>.from(json["images"].map((x) => x)),
    sizeVariants: List<SizeVariant>.from(json["sizeVariants"].map((x) => SizeVariant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "color": color,
    "colorName": colorName,
    "images": List<dynamic>.from(images.map((x) => x)),
    "sizeVariants": List<dynamic>.from(sizeVariants.map((x) => x.toJson())),
  };
}

class SizeVariant {
  SizeVariant({
    required this.size,
    required this.stock,
    required this.price,
    required this.discount,
  });

  final String size;
  final int stock;
  final String price;
  final String discount;

  factory SizeVariant.fromRawJson(String str) => SizeVariant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SizeVariant.fromJson(Map<String, dynamic> json) => SizeVariant(
    size: json["size"],
    stock: json["stock"],
    price: json["price"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "size": size,
    "stock": stock,
    "price": price,
    "discount": discount,
  };
}
