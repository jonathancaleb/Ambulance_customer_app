// To parse this JSON data, do
//
//     final requestResponse = requestResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class RequestResponse {
  RequestResponse({
    required this.status,
    required this.message,
    required this.incident,
  });

  String status;
  String message;
  Incident incident;

  factory RequestResponse.fromRawJson(String str) =>
      RequestResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RequestResponse.fromJson(Map<String, dynamic> json) =>
      RequestResponse(
        status: json["status"],
        message: json["message"],
        incident: Incident.fromJson(json["incident"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "incident": incident.toJson(),
      };
}

class Incident {
  Incident({
    required this.type,
    required this.details,
    required this.location,
    required this.address,
    required this.status,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String type;
  String details;
  Location location;
  String address;
  String status;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Incident.fromRawJson(String str) =>
      Incident.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Incident.fromJson(Map<String, dynamic> json) => Incident(
        type: json["type"],
        details: json["details"],
        location: Location.fromJson(json["location"]),
        address: json["address"],
        status: json["status"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "details": details,
        "location": location.toJson(),
        "address": address,
        "status": status,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Location {
  Location({
    required this.latitude,
    required this.longitude,
  });

  double latitude;
  double longitude;

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
