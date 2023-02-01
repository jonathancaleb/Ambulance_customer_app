import 'package:ambulance_app/src/constants/image_strings.dart';
import 'package:ambulance_app/src/constants/sizes.dart';
import 'package:ambulance_app/src/constants/text_string.dart';
import 'package:ambulance_app/src/controllers/login_controller.dart';
import 'package:ambulance_app/src/views/authentication/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../constants/app_colors.dart';
import '../../models/ApiResponse.dart';
import '../../services/authService.dart';
import '../../widgets/container_widget.dart';
import '../DashboardScreen.dart';
import 'signup_screen.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  LogInController logInController = Get.put(LogInController());
  @override
  Widget build(BuildContext context) {
    //Screen sizes
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final ProgressDialog progressDialog = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false, showLogs: true);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(aDefaultSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //section 1
                  const Image(
                    image: AssetImage(aWelcomeScreenImage),
                    height: 20,
                  ),
                  Text(aloginTitle,
                      style: Theme.of(context).textTheme.headline1),
                  Text(aloginDescription,
                      style: Theme.of(context).textTheme.bodyText1),

                  //section 2
                  Form(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: logInController.usernameController,
                            decoration: InputDecoration(
                                prefixIcon:
                                    const Icon(Icons.person_outline_outlined),
                                labelText: aUserName,
                                hintText: aHint,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100))),
                          ),
                          const SizedBox(
                            height: aFormHeight,
                          ),
                          TextFormField(
                            controller: logInController.passwordController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.fingerprint),
                              labelText: aPassword,
                              hintText: aHintPass,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              suffixIcon: const IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.remove_red_eye_sharp)),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          //forgot password button
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    builder: (context) => Container(
                                      padding:
                                          const EdgeInsets.all(aDefaultSize),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            aForget,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2,
                                          ),
                                          Text(aForgetDescription,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          CotainerWidget(
                                            btnIcon: Icons.mail_outline_rounded,
                                            ttle: aEmail,
                                            subTtle: aResetPassword,
                                            onTap: () {},
                                          ),
                                          const SizedBox(height: 20.0),
                                          CotainerWidget(
                                            btnIcon:
                                                Icons.mobile_friendly_rounded,
                                            ttle: aPhone,
                                            subTtle: aResetPassword2,
                                            onTap: () {},
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(aforgot)),
                          ),
                          //login button
                          SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  enableFeedback: true,
                                  elevation: 0,
                                  shape: const StadiumBorder(),
                                  foregroundColor: aWhiteColor,
                                  backgroundColor: aSecondaryColor,
                                  side:
                                      const BorderSide(color: aSecondaryColor),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: aButtonHeight),
                                ),
                                onPressed: () async {
                                  debugPrint("Logged!");
                                  progressDialog.show();
                                  logInController.logInUser();
                                  progressDialog.hide();
                                },
                                child: Text(logIn.toUpperCase()),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUp()));
                                  },
                                  child: Text.rich(TextSpan(
                                      text: aDontHave,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      children: const [
                                        TextSpan(
                                            text: signUp,
                                            style:
                                                TextStyle(color: Colors.blue))
                                      ]))),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
