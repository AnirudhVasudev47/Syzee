// To parse this JSON data, do
//
//     final influencerStoryModel = influencerStoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class InfluencerStoryModel {
  InfluencerStoryModel({
    required this.data,
  });

  final List<Datum> data;

  factory InfluencerStoryModel.fromRawJson(String str) => InfluencerStoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InfluencerStoryModel.fromJson(Map<String, dynamic> json) => InfluencerStoryModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.storiesImages,
    required this.addedOn,
  });

  final String storiesImages;
  final DateTime addedOn;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    storiesImages: json["stories_images"],
    addedOn: DateTime.parse(json["added_on"]),
  );

  Map<String, dynamic> toJson() => {
    "stories_images": storiesImages,
    "added_on": addedOn.toIso8601String(),
  };
}
