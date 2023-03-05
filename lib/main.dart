import 'package:ambulance_app/src/utils/theme/theme.dart';
import 'package:ambulance_app/src/views/Extra%20screens/chat_screen.dart';
import 'package:ambulance_app/src/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put<ChatController>(ChatController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: AAppTheme.lightTheme,
      darkTheme: AAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 200),
      // home: const SignUp(),
      home: const Splash(),
    );
  }
}
