// To parse this JSON data, do
//
//     final filterModel = filterModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class FilterModel {
  FilterModel({
    required this.filterOneValues,
    required this.filterTwoValues,
    required this.filterThreeValues,
  });

  final List<int> filterOneValues;
  final List<int> filterTwoValues;
  final String filterThreeValues;

  factory FilterModel.fromRawJson(String str) => FilterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
    filterOneValues: List<int>.from(json["filterOneValues"].map((x) => x)),
    filterTwoValues: List<int>.from(json["filterTwoValues"].map((x) => x)),
    filterThreeValues: json["filterThreeValues"],
  );

  Map<String, dynamic> toJson() => {
    "filterOneValues": List<dynamic>.from(filterOneValues.map((x) => x)),
    "filterTwoValues": List<dynamic>.from(filterTwoValues.map((x) => x)),
    "filterThreeValues": filterThreeValues,
  };
}
