import 'dart:convert';

import 'package:equatable/equatable.dart';

class DriverDataModel extends Equatable {
  DriverPosition data;
  String type;
  DriverDataModel({
    required this.data,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data.toMap(),
      'type': type,
    };
  }

  factory DriverDataModel.fromMap(Map<String, dynamic> map) {
    return DriverDataModel(
      data: DriverPosition.fromMap(map['data']),
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverDataModel.fromJson(String source) => DriverDataModel.fromMap(json.decode(source));
  
  @override
  // TODO: implement props
  List<Object?> get props => [data,type];
}

class DriverPosition {
  String lat;
  String long;
  DriverPosition({
    required this.lat,
    required this.long,
  });

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'long': long,
    };
  }

  factory DriverPosition.fromMap(Map<String, dynamic> map) {
    return DriverPosition(
      lat: map['lat'] ?? '',
      long: map['long'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverPosition.fromJson(String source) =>
      DriverPosition.fromMap(json.decode(source));
}
