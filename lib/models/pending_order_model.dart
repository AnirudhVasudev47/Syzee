// To parse this JSON data, do
//
//     final pendingOrderModel = pendingOrderModelFromJson(jsonString);

import 'dart:convert';

class PendingOrderModel {
  PendingOrderModel({
    required this.data,
  });

  final List<Datum> data;

  factory PendingOrderModel.fromRawJson(String str) => PendingOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PendingOrderModel.fromJson(Map<String, dynamic> json) => PendingOrderModel(
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
    required this.dateSlot,
    required this.deliveryDate,
    required this.date,
  });

  final int prodId;
  final int mainCatId;
  final String price;
  final String status;
  final String orderId;
  final List<String> dateSlot;
  final String deliveryDate;
  final DateTime date;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        prodId: json["prodId"],
        mainCatId: json["mainCatId"],
        price: json["price"],
        status: json["status"],
        orderId: json["orderId"],
        dateSlot: List<String>.from(json["dateSlot"].map((x) => x)),
        deliveryDate: json["deliveryDate"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "prodId": prodId,
        "mainCatId": mainCatId,
        "price": price,
        "status": status,
        "orderId": orderId,
        "dateSlot": List<dynamic>.from(dateSlot.map((x) => x)),
        "deliveryDate": deliveryDate,
        "date": date.toIso8601String(),
      };
}
