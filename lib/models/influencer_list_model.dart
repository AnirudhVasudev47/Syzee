// To parse this JSON data, do
//
//     final influencerList = influencerListFromJson(jsonString);

import 'dart:convert';

class InfluencerList {
  InfluencerList({
    required this.data,
  });

  final List<Datum> data;

  factory InfluencerList.fromRawJson(String str) => InfluencerList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InfluencerList.fromJson(Map<String, dynamic> json) => InfluencerList(
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
    required this.image,
    required this.email,
  });

  final int id;
  final String name;
  final String image;
  final String email;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"],
    name: json["NAME"],
    image: json["IMAGE"],
    email: json["EMAIL"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "NAME": name,
    "IMAGE": image,
    "EMAIL": email,
  };
}
