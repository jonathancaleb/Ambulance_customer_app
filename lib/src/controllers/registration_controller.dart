import 'dart:convert';

import 'package:ambulance_app/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../views/DashboardScreen.dart';

class RegistrationController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passconfController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> registerUser() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(Constants.DEV_REGISTER);
      Map body = {
        'username': usernameController.text,
        'password': passwordController.text,
        'passconf': passconfController.text,
        'role': roleController.text
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['code'] == 201) {
          usernameController.clear();
          passwordController.clear();
          passconfController.clear();
          roleController.clear();
          //goto home
          Get.off(const Dashboard());
        } else {
          throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
        }
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: ((context) {
            return SimpleDialog(
              title: const Text("Error"),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          }));
    }
  }
}