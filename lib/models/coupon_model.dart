// To parse this JSON data, do
//
//     final couponModel = couponModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CouponModel {
  CouponModel({
    required this.id,
    required this.code,
    required this.amount,
    required this.type,
    required this.minimum,
    required this.expiry,
  });

  final int id;
  final String code;
  final String amount;
  final String type;
  final String minimum;
  final DateTime expiry;

  factory CouponModel.fromRawJson(String str) => CouponModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
    id: json["id"],
    code: json["code"],
    amount: json["amount"],
    type: json["type"],
    minimum: json["minimum"],
    expiry: DateTime.parse(json["expiry"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "amount": amount,
    "type": type,
    "minimum": minimum,
    "expiry": expiry.toIso8601String(),
  };
}
