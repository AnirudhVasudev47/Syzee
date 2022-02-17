// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class AddressModel {
  AddressModel({
    required this.data,
  });

  final List<Datum> data;

  factory AddressModel.fromRawJson(String str) => AddressModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.email,
    required this.code,
    required this.phone,
    required this.doorNo,
    required this.buildingNo,
    required this.street,
    required this.zone,
    required this.country,
    required this.type,
  });

  final int id;
  final String name;
  final String email;
  final String code;
  final String phone;
  final String doorNo;
  final String buildingNo;
  final String street;
  final String zone;
  final String country;
  final String type;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    code: json["code"],
    phone: json["phone"],
    doorNo: json["doorNo"],
    buildingNo: json["buildingNo"],
    street: json["street"],
    zone: json["zone"],
    country: json["country"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "code": code,
    "phone": phone,
    "doorNo": doorNo,
    "buildingNo": buildingNo,
    "street": street,
    "zone": zone,
    "country": country,
    "type": type,
  };
}
