// To parse this JSON data, do
//
//     final responseModel = responseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ResponseModel {
  ResponseModel({
    required this.facilities,
  });

  List<Facility>? facilities;

  factory ResponseModel.fromRawJson(String str) =>
      ResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        facilities: List<Facility>.from(
            json["facilities"].map((x) => Facility.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "facilities": List<dynamic>.from(facilities!.map((x) => x.toJson())),
      };
}

class Facility {
  Facility({
    required this.name,
    required this.address,
    required this.phone,
  });

  String? name;
  String? address;
  String? phone;

  factory Facility.fromRawJson(String str) =>
      Facility.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Facility.fromJson(Map<String, dynamic> json) => Facility(
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "phone": phone,
      };
}
