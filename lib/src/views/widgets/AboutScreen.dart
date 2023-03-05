import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../onboardingScreen/TermsOfServiceScreen.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Container(
      alignment: Alignment.topCenter,
      color: Colors.grey.withOpacity(0.05),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: width,
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 100,
                    child: Image(
                      image: Svg('assets/bukk_logo_large.svg'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Version 1.0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: "Regular",
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: "Regular",
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width,
              margin: const EdgeInsets.only(
                top: 0,
              ),
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.only(
                top: 15,
                bottom: 1,
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      String _controller = '';
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Scaffold(
                                appBar: AppBar(
                                  elevation: 0,
                                  backgroundColor: Colors.white,
                                  iconTheme: const IconThemeData(
                                    color:
                                        Colors.black, //change your color here
                                  ),
                                  title: const Image(
                                    image: Svg('assets/bukk_logo_large.svg'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                body: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text('Support & Bug Report',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Regular",
                                                fontSize: 18)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 20),
                                        child: Card(
                                          elevation: 8,
                                          child: Column(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                      "Write your something",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: "Regular",
                                                          fontSize: 18)),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: SizedBox(
                                                  height: height * 0.2,
                                                  child: TextFormField(
                                                    minLines: 7,
                                                    maxLines: 7,
                                                    onChanged: (value) =>
                                                        setState(() {
                                                      _controller = value;
                                                    }),
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          'Write your something',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 10),
                                                child: SizedBox(
                                                  width: width / 3.5,
                                                  child: MaterialButton(
                                                    onPressed: () {
                                                      if (_controller.isEmpty) {
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                              'message sent'),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  1000),
                                                        ));
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                      }
                                                    },
                                                    color:
                                                        const Color(0xff042B52),
                                                    child: const Text(
                                                      "Send",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xffffffff),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )));
                      /*
                                Get.toNamed(Routes.supportRoutes);
                                isHistory = false;
                                isNotification = false;
                                isHome = false;
                                isMessage = false;
                                isSetting = true;
                                controller.update();
                                */
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.support_agent_rounded,
                                  color: Colors.grey,
                                ),
                                // Image.asset(
                                //   UIDataImage.support,
                                //   width: 35,
                                // ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Support & Bug Report",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Regular",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_right,
                            color: Color(0xfff1ca2d),
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    height: 1.5,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Scaffold(
                                appBar: AppBar(
                                  elevation: 0,
                                  backgroundColor: Colors.white,
                                  iconTheme: const IconThemeData(
                                    color:
                                        Colors.black, //change your color here
                                  ),
                                  title: const Image(
                                    image: Svg('assets/bukk_logo_large.svg'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                body: const Center(
                                    child: CircularProgressIndicator(
                                  color: const Color(0xff042B52),
                                )),
                              )));
                      /*
                      Get.toNamed(Routes.policyRoutes);
                                isHistory = false;
                                isNotification = false;
                                isHome = false;
                                isMessage = false;
                                isSetting = true;
                                controller.update();
                                 */
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /*
                                    svgImage(
                                      UIDataImage.policy,
                                    ),
                                    */
                          Expanded(
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.send,
                                  color: Colors.grey,
                                ),
                                // Image.asset(
                                //   UIDataImage.policy,
                                //   width: 35,
                                // ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Privacy Policy",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Regular",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_right,
                            color: Color(0xfff1ca2d),
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    height: 1.5,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TermsOfServiceScreen()));
                      // Get.toNamed(Routes.termsRoutes);
                      // isHistory = false;
                      // isNotification = false;
                      // isHome = false;
                      // isMessage = false;
                      // isSetting = true;
                      // controller.update();
                      // Get.find<HomeController>().update();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //svgImage(UIDataImage.terms),
                          Expanded(
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.book_sharp,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Terms & Condition",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Regular",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_right,
                            color: Color(0xfff1ca2d),
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    height: 1.5,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
