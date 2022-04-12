// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ReviewModel {
  ReviewModel({
    required this.average,
    required this.data,
  });

  final average;
  final List<Datum> data;

  factory ReviewModel.fromRawJson(String str) => ReviewModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    average: json["average"] ?? 0,
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "average": average,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.mainId,
    required this.image,
    required this.reviewValue,
    required this.description,
    required this.userEmail,
    required this.createdOn,
  });

  final int id;
  final String orderId;
  final String productId;
  final String mainId;
  final String image;
  final String reviewValue;
  final String description;
  final String userEmail;
  final DateTime createdOn;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"],
    orderId: json["ORDER_ID"],
    productId: json["PRODUCT_ID"],
    mainId: json["MAIN_ID"],
    image: json["IMAGE"],
    reviewValue: json["REVIEW_VALUE"],
    description: json["DESCRIPTION"],
    userEmail: json["USER_EMAIL"],
    createdOn: DateTime.parse(json["CREATED_ON"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "ORDER_ID": orderId,
    "PRODUCT_ID": productId,
    "MAIN_ID": mainId,
    "IMAGE": image,
    "REVIEW_VALUE": reviewValue,
    "DESCRIPTION": description,
    "USER_EMAIL": userEmail,
    "CREATED_ON": createdOn.toIso8601String(),
  };
}
