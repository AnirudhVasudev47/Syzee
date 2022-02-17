// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.code,
    required this.email,
  });

  final int id;
  final String name;
  final String phone;
  final String code;
  final String email;

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    code: json["code"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "code": code,
    "email": email,
  };
}
