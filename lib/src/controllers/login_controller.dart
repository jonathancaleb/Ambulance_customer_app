import 'dart:convert';

import 'package:ambulance_app/src/views/DashboardScreen.dart';
import 'package:ambulance_app/src/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LogInController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> logInUser() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url =
          Uri.parse("https://sos-api-qi1b.onrender.com/api/v1/auth//login");
      Map body = {
        'username': usernameController.text,
        'password': passwordController.text,
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['code'] == 201) {
          var token = json['data']['token'];
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);
          usernameController.clear();
          passwordController.clear();
          //goto home
          Get.off(const HomeScreen());
        } else if (json['code'] == 422) {
          throw jsonDecode(response.body)["message"];
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
