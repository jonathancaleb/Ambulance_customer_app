import 'dart:convert';

class VehicleCategory {
  String image;
  String category_id;
  String name;
  String information;
  VehicleCategory({
    required this.image,
    required this.category_id,
    required this.name,
    required this.information,
  });

  VehicleCategory copyWith({
    String? image,
    String? category_id,
    String? name,
    String? information,
  }) {
    return VehicleCategory(
      image: image ?? this.image,
      category_id: category_id ?? this.category_id,
      name: name ?? this.name,
      information: information ?? this.information,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'category_id': category_id,
      'name': name,
      'information': information,
    };
  }

  factory VehicleCategory.fromMap(Map<String, dynamic> map) {
    return VehicleCategory(
      image: map['image'] ?? '',
      category_id: map['category_id'] ?? '',
      name: map['name'] ?? '',
      information: map['information'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleCategory.fromJson(String source) =>
      VehicleCategory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VehicleCategory(image: $image, category_id: $category_id, name: $name, information: $information)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VehicleCategory &&
        other.image == image &&
        other.category_id == category_id &&
        other.name == name &&
        other.information == information;
  }

  @override
  int get hashCode {
    return image.hashCode ^
        category_id.hashCode ^
        name.hashCode ^
        information.hashCode;
  }
}
