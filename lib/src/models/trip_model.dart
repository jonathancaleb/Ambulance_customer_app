class TripModel {
  final String? driverName,
      vehicleNumberPlate,
      driverPhoneNumber,
      driverPicture;
  TripModel({
    this.driverName,
    this.vehicleNumberPlate,
    this.driverPhoneNumber,
    this.driverPicture,
  });

  factory TripModel.fromJson(Map<String, dynamic> event) {
    Map<String, dynamic> data = event['data'];
    return TripModel(
      driverName: data['driver_name'],
      vehicleNumberPlate: data['vehicle_numberplate'],
      driverPhoneNumber: data['driver_phone_number'],
      driverPicture: data['driver_picture'],
    );
  }
}
