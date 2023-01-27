import 'dart:convert';

class VehiclSubCategory {
  String image;
  String category_id;
  String sub_category_id;
  String name;
  String information;
  String arrival_time;
  double fee;
  VehiclSubCategory({
    required this.image,
    required this.category_id,
    required this.sub_category_id,
    required this.name,
    required this.information,
    required this.arrival_time,
    required this.fee,
  });

  VehiclSubCategory copyWith({
    String? image,
    String? category_id,
    String? sub_category_id,
    String? name,
    String? information,
    String? arrival_time,
    double? fee,
  }) {
    return VehiclSubCategory(
      image: image ?? this.image,
      category_id: category_id ?? this.category_id,
      sub_category_id: sub_category_id ?? this.sub_category_id,
      name: name ?? this.name,
      information: information ?? this.information,
      arrival_time: arrival_time ?? this.arrival_time,
      fee: fee ?? this.fee,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'category_id': category_id,
      'sub_category_id': sub_category_id,
      'name': name,
      'information': information,
      'arrival_time': arrival_time,
      'fee': fee,
    };
  }

  factory VehiclSubCategory.fromMap(Map<String, dynamic> map) {
    return VehiclSubCategory(
      image: map['image'] ?? '',
      category_id: map['category_id'] ?? '',
      sub_category_id: map['sub_category_id'] ?? '',
      name: map['name'] ?? '',
      information: map['information'] ?? '',
      arrival_time: map['arrival_time'] ?? '',
      fee: map['fee']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehiclSubCategory.fromJson(String source) =>
      VehiclSubCategory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VehiclSubCategory(image: $image, category_id: $category_id, sub_category_id: $sub_category_id, name: $name, information: $information, arrival_time: $arrival_time, fee: $fee)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VehiclSubCategory &&
        other.image == image &&
        other.category_id == category_id &&
        other.sub_category_id == sub_category_id &&
        other.name == name &&
        other.information == information &&
        other.arrival_time == arrival_time &&
        other.fee == fee;
  }

  @override
  int get hashCode {
    return image.hashCode ^
        category_id.hashCode ^
        sub_category_id.hashCode ^
        name.hashCode ^
        information.hashCode ^
        arrival_time.hashCode ^
        fee.hashCode;
  }
}
