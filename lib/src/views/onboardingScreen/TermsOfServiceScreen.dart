import 'package:bukk_customer_app/views/onboardingScreen/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../DashboardScreen.dart';

class TermsOfServiceScreen extends StatefulWidget {
  const TermsOfServiceScreen({Key? key}) : super(key: key);

  @override
  State<TermsOfServiceScreen> createState() => _TermsOfServiceScreenState();
}

class _TermsOfServiceScreenState extends State<TermsOfServiceScreen> {
  bool userAgreementIschecked = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Image(
          image: Svg('assets/bukk_logo_large.svg'),
          fit: BoxFit.contain,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 55.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Terms of Use",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Vestibulum in condimentum velit. Vivamus eu lorem id tortor ornare dapibus. '
                  'Nunc malesuada varius tempor. Nulla non enim risus. '
                  'Pellentesque facilisis pulvinar facilisis. '
                  'Nullam at convallis est, non vulputate ipsum. '
                  'Maecenas porttitor auctor tellus, non tincidunt libero vehicula sed. '
                  'Aenean scelerisque dui nisi, vel sollicitudin odio euismod a. '
                  'Aenean porta risus in tortor efficitur, vel imperdiet arcu sagittis. '
                  'Vivamus rhoncus finibus ipsum, eget porttitor lorem gravida et. '
                  'Duis pretium vulputate tortor, id sollicitudin libero mollis vel. '
                  'Suspendisse accumsan ipsum erat, nec lobortis urna mattis non. '
                  'Mauris faucibus, nulla in vehicula pretium, ipsum erat hendrerit massa, '
                  'fringilla aliquam diam dui rhoncus justo. ',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Checkbox(
              //         value: userAgreementIschecked,
              //         onChanged: (bool? value) {
              //           print(value);
              //           setState(() {
              //             userAgreementIschecked = value!;
              //           });
              //         },
              //       ),
              //       const Text(
              //         "I agree to these terms of use ",
              //         style: TextStyle(fontSize: 16, color: Colors.black),
              //       )
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: SizedBox(
              //     height: screenHeight * 0.07,
              //     width: screenWidth * 0.6,
              //     child: MaterialButton(
              //       disabledColor: Colors.grey,
              //       color: userAgreementIschecked
              //           ? const Color(0xff042B52)
              //           : Colors.grey,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12.0),
              //         side: BorderSide(
              //           color: userAgreementIschecked
              //               ? const Color(0xff042B52)
              //               : Colors.grey,
              //         ),
              //       ),
              //       onPressed: userAgreementIschecked
              //           ? () {
              //               //Go to Dashboard Screen
              //               Navigator.pushReplacement(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) =>
              //                           const WelcomeScreen()));
              //             }
              //           : null,
              //       child: Text("Next",
              //           style: TextStyle(
              //             fontSize: 18,
              //             color:
              //                 userAgreementIschecked ? Color(0xffF1CA2D) : null,
              //           )),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
