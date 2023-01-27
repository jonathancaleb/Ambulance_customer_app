import 'dart:convert';

import 'package:bukk_customer_app/constants/Constants.dart';
import 'package:bukk_customer_app/controllers/BookingController.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class LocationService {
  final bookingController = Get.put(BookingController());
  Future<LatLng> getPosition() async {
    final Location location = Location();
    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) throw 'GPS service is disabled';
    }
    if (await location.hasPermission() == PermissionStatus.denied) {
      if (await location.requestPermission() != PermissionStatus.granted) {
        throw 'No GPS permissions';
      }
    }
    final LocationData data = await location.getLocation();
    return LatLng(data.latitude!, data.longitude!);
  }

  void getAddress(double lat, double lng) async {
    String address = "";
    String latLng = "$lat,$lng";

    try {
      String apiKey = "AIzaSyCBx7lRHvmRJEeMbCIJWgjsUArU24Awq_k";
      final Uri uri = Uri.parse(
          Constants.GET_ADDRESS_FROM_LAT_LNG + latLng + "&key=" + apiKey);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        address = json.decode(response.body)["formatted_address"].toString();
        bookingController.updateCurrentLocationAddress(address);
      } else {
        throw Exception("Failed to get address");
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
