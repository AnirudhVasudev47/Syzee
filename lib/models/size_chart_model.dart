// To parse this JSON data, do
//
//     final sizeChartModel = sizeChartModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class SizeChartModel {
  SizeChartModel({
    required this.result,
  });

  final Result result;

  factory SizeChartModel.fromRawJson(String str) => SizeChartModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SizeChartModel.fromJson(Map<String, dynamic> json) => SizeChartModel(
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result.toJson(),
  };
}

class Result {
  Result({
    required this.tableHeader,
    required this.tableRows,
    required this.sizeImage,
    required this.modelSize,
    required this.modelHeight,
    required this.modelChest,
  });

  final List<String> tableHeader;
  final List<List<String>> tableRows;
  final String sizeImage;
  final String modelSize;
  final String modelHeight;
  final String modelChest;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    tableHeader: List<String>.from(json["tableHeader"].map((x) => x)),
    tableRows: List<List<String>>.from(json["tableRows"].map((x) => List<String>.from(x.map((x) => x)))),
    sizeImage: json["sizeImage"],
    modelSize: json["modelSize"],
    modelHeight: json["modelHeight"],
    modelChest: json["modelChest"],
  );

  Map<String, dynamic> toJson() => {
    "tableHeader": List<dynamic>.from(tableHeader.map((x) => x)),
    "tableRows": List<dynamic>.from(tableRows.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "sizeImage": sizeImage,
    "modelSize": modelSize,
    "modelHeight": modelHeight,
    "modelChest": modelChest,
  };
}
