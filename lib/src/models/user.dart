import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  String email_address;
  String password;
  String phone_number;
  List<String> roles;
  String registration_status;
  String type;
  User({
    required this.email_address,
    required this.password,
    required this.phone_number,
    required this.roles,
    required this.registration_status,
    required this.type,
  });

  User copyWith({
    String? email_address,
    String? password,
    String? phone_number,
    List<String>? roles,
    String? registration_status,
    String? type,
  }) {
    return User(
      email_address: email_address ?? this.email_address,
      password: password ?? this.password,
      phone_number: phone_number ?? this.phone_number,
      roles: roles ?? this.roles,
      registration_status: registration_status ?? this.registration_status,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email_address': email_address,
      'password': password,
      'phone_number': phone_number,
      'roles': roles,
      'registration_status': registration_status,
      'type': type,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email_address: map['email_address'] ?? '',
      password: map['password'] ?? '',
      phone_number: map['phone_number'] ?? '',
      roles: List<String>.from(map['roles']),
      registration_status: map['registration_status'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(email_address: $email_address, password: $password, phone_number: $phone_number, roles: $roles, registration_status: $registration_status, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.email_address == email_address &&
        other.password == password &&
        other.phone_number == phone_number &&
        listEquals(other.roles, roles) &&
        other.registration_status == registration_status &&
        other.type == type;
  }

  @override
  int get hashCode {
    return email_address.hashCode ^
        password.hashCode ^
        phone_number.hashCode ^
        roles.hashCode ^
        registration_status.hashCode ^
        type.hashCode;
  }
}
