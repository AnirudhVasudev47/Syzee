// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class OrderListModel {
  OrderListModel({
    required this.data,
  });

  final List<Datum> data;

  factory OrderListModel.fromRawJson(String str) => OrderListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.prodId,
    required this.mainCatId,
    required this.price,
    required this.status,
    required this.orderId,
    required this.date,
    required this.orderIndex,
  });

  final int prodId;
  final int mainCatId;
  final String price;
  final String status;
  final String orderId;
  final DateTime date;
  final int orderIndex;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    prodId: json["prodId"],
    mainCatId: json["mainCatId"],
    price: json["price"],
    status: json["status"],
    orderId: json["orderId"],
    date: DateTime.parse(json["date"]),
    orderIndex: json["orderIndex"],
  );

  Map<String, dynamic> toJson() => {
    "prodId": prodId,
    "mainCatId": mainCatId,
    "price": price,
    "status": status,
    "orderId": orderId,
    "date": date.toIso8601String(),
    "orderIndex": orderIndex,
  };
}
