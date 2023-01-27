import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../DashboardScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController pageController = PageController(
    initialPage: 0,
  );
  bool userAgreementIschecked = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: PageView(
          controller: pageController,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    width: screenWidth,
                    image: const AssetImage('assets/welcome_img.png'),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Welcome to',
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: screenWidth * 0.15,
                      child: const Image(
                        image: AssetImage('assets/bukk_logo_large.png'),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: 300,
                      height: 100,
                      child: Text(
                        "Lorem ipsum dolor sit amet, "
                        "consectetur adipiscing elit. "
                        "Proin non dolor et arcu tincidunt "
                        "auctor at nec ante. In hac habitasse "
                        "platea dictumst.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  width: screenWidth,
                  image: const AssetImage('assets/welcome_img.png'),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Welcome to',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: screenWidth * 0.15,
                    child: const Image(
                      image: AssetImage('assets/bukk_logo_large.png'),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: 300,
                    height: 100,
                    child: Text(
                      "Lorem ipsum dolor sit amet, "
                      "consectetur adipiscing elit. "
                      "Proin non dolor et arcu tincidunt "
                      "auctor at nec ante. In hac habitasse "
                      "platea dictumst.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.6,
                    child: MaterialButton(
                      enableFeedback: true,
                      color: const Color(0xff042B52),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          side: const BorderSide(color: Color(0xff042B52))),
                      onPressed: () {
                        //Todo: Call the login logic
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Dashboard()));
                      },
                      child: const Text(
                        'Get Started',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xffF1CA2D)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: SizedBox(
          height: screenHeight * 0.08,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: TextButton(
                  onPressed: () {
                    // pageController.jumpToPage(2);
                    //Go to Dashboard Screen
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()));
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: Color(0xff042B52)),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 2,
                      onDotClicked: (index) => pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                      effect: const WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        dotColor: Colors.grey,
                        activeDotColor: Color(0xffF1CA2D),
                        type: WormType.normal,
                        // strokeWidth: 5,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: true,
                  child: TextButton(
                    onPressed: () {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                          color: Color(0xff042B52), fontFamily: "Regular"),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
