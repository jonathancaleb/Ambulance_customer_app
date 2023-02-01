// ignore: file_names
import 'package:get/get.dart';

class UserController extends GetxController {
  String countryCode = '';
  String phoneNumber = '';

  updateCountryCode(String code) {
    countryCode = code;
    update();
  }

  updatePhoneNumber(String number) {
    phoneNumber = number;
    update();
  }
}
