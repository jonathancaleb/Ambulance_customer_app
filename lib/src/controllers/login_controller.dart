import 'dart:convert';

import 'package:ambulance_app/src/helper/loading.dart';
import 'package:ambulance_app/src/views/DashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../helper/snackbar.dart';
import '../models/login_response.dart';

class LogInController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  logInUser() async {
    LoadingUtils.showLoader();

    try {
      var headers = {'Content-Type': 'application/json'};
      var url =
          Uri.parse("https://sos-api-qi1b.onrender.com/api/v1/auth/login");
      Map body = {
        'username': usernameController.text,
        'password': passwordController.text,
      };
      SharedPreferences prefs = await SharedPreferences.getInstance();
      LoginResponse jsonResponse;
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        jsonResponse = LoginResponse.fromJson(jsonDecode(response.body));
        // if (json['code'] == 201) {
        prefs.setString('token', jsonResponse.token);
        prefs.setString('userId', jsonResponse.user.id);
        prefs.setString('username', jsonResponse.user.username);
        usernameController.clear();
        passwordController.clear();
        Get.off(() => const Dashboard());
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
