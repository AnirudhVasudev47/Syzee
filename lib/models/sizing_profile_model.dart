// To parse this JSON data, do
//
//     final sizingProfileModel = sizingProfileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class SizingProfileModel {
  SizingProfileModel({
    required this.data,
    required this.selectedId,
  });

  final List<Datum> data;
  final int selectedId;

  factory SizingProfileModel.fromRawJson(String str) => SizingProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SizingProfileModel.fromJson(Map<String, dynamic> json) => SizingProfileModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    selectedId: json["selectedId"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "selectedId": selectedId,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.height,
    required this.heightUnit,
    required this.weight,
    required this.weightUnit,
    required this.upperBody,
    required this.lowerBody,
    required this.length,
    required this.width,
    required this.chest,
    required this.sleevesFromNeck,
    required this.waist,
    required this.waistFromNeck,
    required this.chestFromNeck,
    required this.hips,
    required this.status,
    required this.createdOn,
    required this.createdBy,
    required this.resetOn,
  });

  final int id;
  final String height;
  final String heightUnit;
  final String weight;
  final String weightUnit;
  final String upperBody;
  final String lowerBody;
  final String length;
  final String width;
  final String chest;
  final String sleevesFromNeck;
  final String waist;
  final String waistFromNeck;
  final String chestFromNeck;
  final String hips;
  final int status;
  final DateTime createdOn;
  final String createdBy;
  final String resetOn;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    height: json["height"],
    heightUnit: json["height_unit"],
    weight: json["weight"],
    weightUnit: json["weight_unit"],
    upperBody: json["upper_body"],
    lowerBody: json["lower_body"],
    length: json["length"],
    width: json["width"],
    chest: json["chest"],
    sleevesFromNeck: json["sleeves_from_neck"],
    waist: json["waist"],
    waistFromNeck: json["waist_from_neck"],
    chestFromNeck: json["chest_from_neck"],
    hips: json["hips"],
    status: json["status"],
    createdOn: DateTime.parse(json["created_on"]),
    createdBy: json["created_by"],
    resetOn: json["reset_on"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "height": height,
    "height_unit": heightUnit,
    "weight": weight,
    "weight_unit": weightUnit,
    "upper_body": upperBody,
    "lower_body": lowerBody,
    "length": length,
    "width": width,
    "chest": chest,
    "sleeves_from_neck": sleevesFromNeck,
    "waist": waist,
    "waist_from_neck": waistFromNeck,
    "chest_from_neck": chestFromNeck,
    "hips": hips,
    "status": status,
    "created_on": createdOn.toIso8601String(),
    "created_by": createdBy,
    "reset_on": resetOn,
  };
}
