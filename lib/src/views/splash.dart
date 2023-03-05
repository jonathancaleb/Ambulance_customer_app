import 'dart:io';

import 'package:ambulance_app/src/views/authentication/signup_screen.dart';
import 'package:ambulance_app/src/views/onboardingScreen/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/authService.dart';
import '../utils/utils.dart';
import 'DashboardScreen.dart';
import 'authentication/login_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      _checkStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image(
                height: screenHeight * 0.7,
                width: screenWidth * 0.8,
                image: const AssetImage('assets/splash_image_pg.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    if (mounted) {
      await Utils.handleLocationPermission(context, onComplete: () {
        navigateRoutes(isLoggedIn);
      }, onReject: () async {
        await Future.delayed(const Duration(milliseconds: 2000));
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else {
          exit(0);
        }
        // Navigator.popUntil(context, (route) => false);
      });
    }
  }

  void navigateRoutes(isLoggedIn) {
    // Navigator.
    if (!isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    } else {
      checkRegistrationStatus().then((value) => {
            if (value == "unverified_phone_number")
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LogIn()),
                )
              }
            else if (value == "complete")
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Dashboard()),
                )
              }
            else
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()),
                )
              }
          });
    }
  }
}
