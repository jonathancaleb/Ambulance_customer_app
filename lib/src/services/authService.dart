import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bukk_customer_app/Sockets/connection.dart';
import 'package:bukk_customer_app/constants/Constants.dart' as Constants;
import 'package:bukk_customer_app/models/ApiResponse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//Header for the auth requests
const Map<String, String> headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

//Verify Customer OTP code sent via SMS
Future<bool> verifyOtp(String otp) async {
  try {
    //get Access token
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("access_token").toString();
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Token " + token
    };

    var uri = Uri.parse(Constants.Constants.DEV_VERIFY_OTP);
    var requestBody = jsonEncode({"otp_token": int.parse(otp)});
    //Send otp verification request
    final response = await http.post(uri, headers: headers, body: requestBody);
    if (response.statusCode == 200) {
      prefs.setString("registration_status", "complete");
      SocketManager socketManager = SocketManager();
      socketManager.initSocketConnection();
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> sendFeedback(String feedback) async {
  try {
    //get Access token
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("access_token").toString();
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };
    var uri = Uri.parse(Constants.Constants.VERIFY_OTP_API_ENDPOINT);
    var requestBody = jsonEncode({"feedback_message": feedback});

    final response = await http.post(uri, headers: headers, body: requestBody);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> resendOTPCode() async {
  try {
    //get Access token
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("access_token").toString();
    String phoneNumber = prefs.getString("phoneNumber").toString();

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Token " + token
    };

    var uri = Uri.parse(Constants.Constants.DEV_RESEND_OTP);
    var requestBody = jsonEncode({"phone_number": phoneNumber});
    //Send otp verification request
    final response = await http.post(uri, headers: headers, body: requestBody);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> logout() async {
  try {
    //get Access token
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("access_token").toString();
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Token " + token
    };

    var uri = Uri.parse(Constants.Constants.DEV_LOGOUT);
    //Send otp verification request
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      //Clear the shared prefs
      await prefs.clear();
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> checkToken() async {
  try {
    //get Access token
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("access_token").toString();

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Token " + token,
      "Role": "accounts"
    };

    var uri = Uri.parse(Constants.Constants.DEV_TOKEN);
    //Send otp verification request
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      prefs.setString("registration_status", "incomplete_phone_number");
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<String> checkRegistrationStatus() async {
  try {
    //get Access token
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("access_token").toString();

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Token " + token,
      "Role": "accounts"
    };

    var uri = Uri.parse(Constants.Constants.DEV_TOKEN);
    //Send otp verification request
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      String registrationstatus =
          json.decode(response.body)["registration_status"];
      String phoneNumber = json.decode(response.body)["phone_number"];
      prefs.setString("phoneNumber", phoneNumber);
      return registrationstatus;
    } else {
      return "failed";
    }
  } catch (e) {
    print(e.toString());
    return "failed";
  }
}

/**
   * Below this point on, the functions define
   * The authentication logic for the new authenticatoin flow
   */

Future<ApiResponse> loginWithPhoneNumber(String phoneNumber) async {
  try {
    var uri = Uri.parse("https://dev-accounts.bukkhl.work/v1/login");
    var requestBody =
        jsonEncode({"phone_number": phoneNumber, "is_driver": false});
    //Send otp verification request
    final response = await http.post(uri, headers: headers, body: requestBody);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();

      //Getting the response data
      String token = json.decode(response.body)["access_token"];
      String registrationStatus =
          json.decode(response.body)["registration_status"];
      String emailAddress = json.decode(response.body)["email"];
      bool isNewUser = json.decode(response.body)["is_new"];
      String uuid = json.decode(response.body)["uuid"];

      //Saving the data to shared preferences
      await prefs.setBool("isLoggedIn", true);
      await prefs.setString("access_token", token);
      await prefs.setString("registration_status", registrationStatus);
      await prefs.setString("phoneNumber", phoneNumber);
      await prefs.setString("email", emailAddress);
      await prefs.setBool("inNewUser", isNewUser);
      await prefs.setString("uuid", uuid);
      if (!isNewUser) {
        await getUserProfile(); //get user profile info
      }
      return ApiResponse(status: true, message: "Authentication successful");
    } else {
      return ApiResponse(status: false, message: response.body.toString());
    }
  } catch (e) {
    print(e.toString());
    return ApiResponse(status: false, message: e.toString());
  }
}

Future<ApiResponse> updateUserProfile(
    String firstName, String lastName, String emailAddress) async {
  try {
    //get Access token
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("access_token").toString();
    String uuid = prefs.getString("uuid").toString();

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Token $token"
    };

    var uri = Uri.parse("https://dev-accounts.bukkhl.work/v1/user/$uuid");
    var requestBody = jsonEncode({
      "first_name": firstName,
      "last_name": lastName,
      "email": emailAddress
    });
    //Send otp verification request
    final response = await http.put(uri, headers: headers, body: requestBody);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", emailAddress);
      await prefs.setString("firstName", firstName);
      await prefs.setString("lastName", lastName);

      return ApiResponse(status: true, message: "Profile updates successfully");
    } else {
      return ApiResponse(status: false, message: response.body.toString());
    }
  } catch (e) {
    print(e.toString());
    return ApiResponse(status: false, message: e.toString());
  }
}

Future<bool?> getNewUserStatus() async {
  bool? isNewUser = false;
  try {
    final prefs = await SharedPreferences.getInstance();

    isNewUser = prefs.getBool("inNewUser");
    return isNewUser;
  } catch (e) {
    print(e.toString());
    return isNewUser;
  }
}

Future<bool> getUserProfile() async {
  try {
    //get Access token
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("access_token").toString();
    String uuid = prefs.getString("uuid").toString();

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Token $token"
    };

    var uri = Uri.parse("https://dev-accounts.bukkhl.work/v1/user/$uuid");

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      //Getting the response data
      String firstName = json.decode(response.body)["first_name"];
      String lastName = json.decode(response.body)["last_name"];
      String emailAddress = json.decode(response.body)["emails"];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("firstName", firstName);
      await prefs.setString("lastName", lastName);
      await prefs.setString("email", emailAddress);
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}
