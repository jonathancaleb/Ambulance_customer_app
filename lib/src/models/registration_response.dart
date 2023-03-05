// To parse this JSON data, do
//
//     final registrationResponse = registrationResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class RegistrationResponse {
  RegistrationResponse({
    required this.status,
    required this.message,
    required this.user,
  });

  String status;
  String message;
  User user;

  factory RegistrationResponse.fromRawJson(String str) =>
      RegistrationResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      RegistrationResponse(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.userId,
    required this.username,
    required this.role,
    required this.isActive,
  });

  String userId;
  String username;
  String role;
  bool isActive;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        username: json["username"],
        role: json["role"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "role": role,
        "isActive": isActive,
      };
}
