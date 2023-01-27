import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: SizedBox(
        height: screenHeight * 0.3,
        width: screenWidth * 0.4,
        child: Lottie.asset('assets/searching_animation.json'),
      ),
    );
  }
}
