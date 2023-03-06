import 'dart:convert';
import 'package:ambulance_app/src/helper/loading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/RequestController.dart';
import 'package:get/get.dart';

import '../controllers/map_controller.dart';
import '../models/request_response.dart';

final bookingController = Get.put(RequestController());
submitBookingRequest() async {
  LoadingUtils.showLoader();
  try {
    //get Access token and user ID
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token").toString();
    String userId = prefs.getString("userId").toString();

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Token $token"
    };
    var uri = Uri.parse(
        "https://sos-api-qi1b.onrender.com/api/v1/incidents/request_help");

    //TODO: Edit the booking object to include all fields
    var requestBody = jsonEncode({
      "pickup_location": {
        "lat": getxMapController.getPickupLatitude(),
        "long": getxMapController.getPickupLongitude(),
        "name": getxMapController.currentAddress,
      },
      // "delivery_location": {
      //   "name": getxMapController.destinationAddress,
      //   "lat": getxMapController.getDestinationLatitude(),
      //   "long": getxMapController.getDestinationLongitude()
      // },
      "user": userId,
    });
    RequestResponse jsonResponse;
    final response = await http.post(uri, headers: headers, body: requestBody);

    if (response.statusCode == 200) {
      jsonResponse = RequestResponse.fromJson(jsonDecode(response.body));
      Get.snackbar('Success', 'Incident submitted successfully');
    } else {
      print(response.body.toString());
      Get.snackbar('Error', 'Submission failed');
    }
  } catch (e) {
    print(e.toString());
    Get.snackbar('Error', 'Submission failed');
  } finally {
    LoadingUtils.hideLoader();
  }
}
