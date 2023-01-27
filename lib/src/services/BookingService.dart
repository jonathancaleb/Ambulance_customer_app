import 'dart:convert';

import 'package:bukk_customer_app/constants/Constants.dart' as Constants;
import 'package:bukk_customer_app/controllers/trip_controller.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/BookingController.dart';
import '../controllers/DriverController.dart';
import 'package:get/get.dart';

import '../controllers/map_controller.dart';

final bookingController = Get.put(BookingController());
final driverController = Get.put(DriverController());
final tripcontroller = Get.put(TripController());

Future<bool> submitBookingRequest() async {
  try {
    //get Access token
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("access_token").toString();
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Token $token"
    };
    var uri = Uri.parse(Constants.Constants.SUBMIT_BOOKING_REQUEST);

    //TODO: Edit the booking object to include all fields
    var requestBody = jsonEncode({
      "pickup_location": {
        "lat": getxMapController.getPickupLatitude(),
        "long": getxMapController.getPickupLongitude(),
        "name": getxMapController.currentAddress,
      },
      "delivery_location": {
        "name": getxMapController.destinationAddress,
        "lat": getxMapController.getDestinationLatitude(),
        "long": getxMapController.getDestinationLongitude()
      },
      "category_id": bookingController.vehicleCategoryId,
      "date": DateTime.now().toIso8601String(),
      "offloading": bookingController.OffLoading,
      "loading": bookingController.loading,
      "payment_method": "card",
      "payment_id": "0d785d7f-d460-4c2e-95a8-908256884a1b",
      "amount": "100"
    });

    final response = await http.post(uri, headers: headers, body: requestBody);

    if (response.statusCode == 201) {
      ///
      ///Wait for the web socket connection to update the driver controller
      ///and read the contents of the booking stage
      ///return true is the booking stage indicates driver matched
      ///return false is the booking stage indiciates driver not found.
      ///
      for (int i = 0; i < 60; i++) {
        await Future.delayed(const Duration(milliseconds: 1000), () {
          if (driverController.bookingStage.toString() == "driver-matched") {
            return true;
          } else {
            return false;
          }
        });
        return false;
      }
      return false;
    } else {
      print(response.body.toString());
      return false;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}
