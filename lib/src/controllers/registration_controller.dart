import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/loading.dart';
import '../helper/snackbar.dart';
import '../models/registration_response.dart';
import '../views/DashboardScreen.dart';

class RegistrationController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passconfController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  registerUser() async {
    LoadingUtils.showLoader();
    try {
      var headers = {'Content-Type': 'application/json'};
      var url =
          Uri.parse("https://sos-api-qi1b.onrender.com/api/v1/auth/register");
      Map body = {
        'username': usernameController.text,
        'password': passwordController.text,
        'passconf': passconfController.text,
        'role': roleController.text,
      };
      SharedPreferences prefs = await SharedPreferences.getInstance();
      RegistrationResponse jsonResponse;
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      print(response.body);
      if (response.statusCode == 201) {
        jsonResponse = RegistrationResponse.fromJson(jsonDecode(response.body));
        // if (json['code'] == 201) {
        prefs.setString('userId', jsonResponse.user.userId);
        usernameController.clear();
        passwordController.clear();
        passconfController.clear();
        //goto home
        Get.off(() => const Dashboard());
        // } else if (json['code'] == 422) {
        //   throw jsonDecode(response.body)["message"];
        // }
      } else {
        var error = jsonDecode(response.body)['error'];
        snackbar(error);
      }
    } catch (e) {
      LoadingUtils.hideLoader();
      snackbar(e.toString());
    }
  }
}
