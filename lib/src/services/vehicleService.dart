import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/BookingController.dart';
import '../models/VehicleCategory.dart';
import '../models/VehicleSubCategory.dart';

final bookingController = Get.put(BookingController());

/*
Purpose: Fetches Vehicle category list from the server
Params: None
*/
Future<List<VehicleCategory>> getVechicleCategories() async {
  try {
    //Get access token
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("access_token") as String;

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Token $token"
    };

    // var uri = Uri.parse(Constants.Constants.DEV_GET_VEHICLE_CATEGORIES);;
    var uri =
        Uri.parse("https://dev-profile.bukkhl.work/v1/vehicle-categories");

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      List jsonResponse =
          json.decode(response.body).cast<Map<String, dynamic>>();

      return jsonResponse
          .map<VehicleCategory>((json) => VehicleCategory.fromMap(json))
          .toList();
    } else {
      throw Exception("Unexpected error occured");
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

/*
Purpose: Fetches Vehicle sub-categories from the server
Params: String vehicleCategoryId
*/
Future<List<VehiclSubCategory>> getVehicleSubCategory(
    String catergoryId) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("access_token").toString();

    String id = bookingController.vehicleCategoryId;
    print(id);

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Token $token"
    };

    var uri = Uri.parse(
        "https://dev-profile.bukkhl.work/v1/vehicle-categories?category_id=" +
            catergoryId);

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      List jsonResponse =
          json.decode(response.body).cast<Map<String, dynamic>>();
      return jsonResponse
          .map<VehiclSubCategory>((json) => VehiclSubCategory.fromMap(json))
          .toList();
    } else {
      throw Exception("Unexpected error occured");
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
