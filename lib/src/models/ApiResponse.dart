import 'dart:convert';

class ApiResponse {
  bool status;
  String message;
  ApiResponse({
    required this.status,
    required this.message,
  });

  ApiResponse copyWith({
    bool? status,
    String? message,
  }) {
    return ApiResponse(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
    };
  }

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiResponse.fromJson(String source) =>
      ApiResponse.fromMap(json.decode(source));

  @override
  String toString() => 'ApiResponse(status: $status, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApiResponse &&
        other.status == status &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode;
}
