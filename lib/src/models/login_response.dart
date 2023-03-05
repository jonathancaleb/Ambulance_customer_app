// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

class LoginResponse {
  LoginResponse({
    required this.status,
    required this.token,
    required this.user,
  });

  String status;
  String token;
  User user;

  factory LoginResponse.fromRawJson(String str) =>
      LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.role,
  });

  String id;
  String username;
  String role;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "role": role,
      };
}
