import 'package:ambulance_app/src/constants/sizes.dart';
import 'package:ambulance_app/src/constants/text_string.dart';
import 'package:ambulance_app/src/views/authentication/login_screen.dart';
import 'package:ambulance_app/src/views/authentication/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/image_strings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = MediaQuery.of(context).size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? aSecondaryColor : aPrimaryColor,
      // ignore: avoid_unnecessary_containers
      body: Container(
          padding: const EdgeInsets.all(aDefaultSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: const AssetImage(aWelcomeScreenImage),
                height: height * 0.4,
              ),
              Column(
                children: [
                  Text(
                    aWelcomeTitle,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    aWelcomeSubTitle,
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () => Get.to(() => const LogIn()),
                        style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          foregroundColor: aSecondaryColor,
                          side: const BorderSide(color: aSecondaryColor),
                          padding: const EdgeInsets.symmetric(
                              vertical: aButtonHeight),
                        ),
                        child: Text(logIn.toUpperCase())),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () => Get.to(() => const SignUp()),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const StadiumBorder(),
                          foregroundColor: aWhiteColor,
                          backgroundColor: aSecondaryColor,
                          side: const BorderSide(color: aSecondaryColor),
                          padding: const EdgeInsets.symmetric(
                              vertical: aButtonHeight),
                        ),
                        child: Text(signUp.toLowerCase())),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
