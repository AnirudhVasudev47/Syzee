// To parse this JSON data, do
//
//     final couponModel = couponModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CouponListModel {
  CouponListModel({
    required this.data,
  });

  final List<Datum> data;

  factory CouponListModel.fromRawJson(String str) => CouponListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CouponListModel.fromJson(Map<String, dynamic> json) => CouponListModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
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

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
