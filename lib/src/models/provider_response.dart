// To parse this JSON data, do
//
//     final providerResponse = providerResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ProviderResponse {
  ProviderResponse({
    required this.status,
    required this.message,
    required this.providers,
    required this.locations,
  });

  String status;
  String message;
  List<Provider> providers;
  List<dynamic> locations;

  factory ProviderResponse.fromRawJson(String str) =>
      ProviderResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProviderResponse.fromJson(Map<String, dynamic> json) =>
      ProviderResponse(
        status: json["status"],
        message: json["message"],
        providers: List<Provider>.from(
            json["providers"].map((x) => Provider.fromJson(x))),
        locations: List<dynamic>.from(json["locations"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "providers": List<dynamic>.from(providers.map((x) => x.toJson())),
        "locations": List<dynamic>.from(locations.map((x) => x)),
      };
}

class Provider {
  Provider({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.website,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String name;
  String address;
  String phone;
  String email;
  String website;
  String type;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Provider.fromRawJson(String str) =>
      Provider.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json["_id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        website: json["website"],
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "address": address,
        "phone": phone,
        "email": email,
        "website": website,
        "type": type,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
