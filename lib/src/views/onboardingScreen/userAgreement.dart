// import 'package:bukk_customer_app/views/DashboardScreen.dart';
import 'package:flutter/material.dart';

import '../DashboardScreen.dart';

class UserAgreementScreen extends StatefulWidget {
  const UserAgreementScreen({Key? key}) : super(key: key);

  @override
  State<UserAgreementScreen> createState() => _UserAgreementScreenState();
}

class _UserAgreementScreenState extends State<UserAgreementScreen> {
  bool userAgreementIschecked = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset('assets/bukk_logo_1.png', fit: BoxFit.contain),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "User Agreement",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
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
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: userAgreementIschecked,
                  onChanged: (bool? value) {
                    print(value);
                    setState(() {
                      userAgreementIschecked = value!;
                    });
                  },
                ),
                const Text(
                  "I agree to the user agreement ",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: screenHeight * 0.07,
              width: screenWidth * 0.6,
              child: MaterialButton(
                color: const Color(0xff042B52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: const BorderSide(
                    color: Color(0xff042B52),
                  ),
                ),
                onPressed: () {
                  //Go to Dashboard Screen
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Dashboard()));
                },
                child: const Text("Next",
                    style: TextStyle(fontSize: 20, color: Color(0xffF1CA2D))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
