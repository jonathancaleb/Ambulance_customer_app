import 'dart:convert';

class LoginResponse {
  String access_token;
  String refresh_token;
  String registration_status;
  LoginResponse({
    required this.access_token,
    required this.refresh_token,
    required this.registration_status,
  });

  LoginResponse copyWith({
    String? access_token,
    String? refresh_token,
    String? registration_status,
  }) {
    return LoginResponse(
      access_token: access_token ?? this.access_token,
      refresh_token: refresh_token ?? this.refresh_token,
      registration_status: registration_status ?? this.registration_status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'access_token': access_token,
      'refresh_token': refresh_token,
      'registration_status': registration_status,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      access_token: map['access_token'] ?? '',
      refresh_token: map['refresh_token'] ?? '',
      registration_status: map['registration_status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'LoginResponse(access_token: $access_token, refresh_token: $refresh_token, registration_status: $registration_status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginResponse &&
        other.access_token == access_token &&
        other.refresh_token == refresh_token &&
        other.registration_status == registration_status;
  }

  @override
  int get hashCode =>
      access_token.hashCode ^
      refresh_token.hashCode ^
      registration_status.hashCode;
}
