import 'dart:convert';

import 'package:ambulance_app/src/services/exporter.dart';

import '../models/hospital_response.dart';
import 'package:http/http.dart' as http;

class HospitalController extends GetxController {
  var isLoading = false.obs;
  ResponseModel? responseModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    getFacilities();
  }

  getFacilities() async {
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.tryParse(
          'https://sos-api-qi1b.onrender.com/api/v1/facilities/list')!);
      print(response.body);
      if (response.statusCode == 200) {
        //data success
        var result = jsonDecode(response.body);
        responseModel = ResponseModel.fromJson(result);
      } else {
        //error
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }
}
