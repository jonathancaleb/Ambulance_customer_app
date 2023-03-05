import 'package:ambulance_app/src/constants/app_colors.dart';
import 'package:ambulance_app/src/constants/sizes.dart';
import 'package:ambulance_app/src/constants/text_string.dart';
import 'package:ambulance_app/src/controllers/registration_controller.dart';
import 'package:ambulance_app/src/views/authentication/login_screen.dart';
import 'package:ambulance_app/src/widgets/form_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../constants/dimensions.dart';
import '../../widgets/big_text.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _selectedRole = 'User'; // default value

  RegistrationController registrationController =
      Get.put(RegistrationController());

  final roleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedRole = "User";
  }

  @override
  Widget build(BuildContext context) {
    //Screen sizes
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(aDefaultSize),
              child: Column(children: [
                const FormHeaderWidget(
                    title: aSignupTitle, subTitle: aSignupDescription),
                // Row(
                //   children: [
                //     const Expanded(
                //         child: Padding(
                //       padding: EdgeInsets.all(8.0),
                //       child: Divider(
                //         thickness: 2,
                //         color: AppColors.black,
                //       ),
                //     )),
                //     BigText(
                //       text: 'SOS-AMBULANCE',
                //       size: Dimensions.font20 * 1.8,
                //     ),
                //     const Expanded(
                //         child: Padding(
                //       padding: EdgeInsets.all(8.0),
                //       child: Divider(
                //         thickness: 2,
                //         color: AppColors.black,
                //       ),
                //     )),
                //   ],
                // ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Form(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: registrationController.usernameController,
                        decoration: InputDecoration(
                            label: const Text(aFullName),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100)),
                            prefixIcon: const Icon(Icons.person_outline_rounded,
                                color: aSecondaryColor),
                            labelStyle: const TextStyle(color: aSecondaryColor),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: const BorderSide(
                                    width: 2.0, color: aSecondaryColor))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: registrationController.passwordController,
                        decoration: InputDecoration(
                            label: const Text(aPassword),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100)),
                            prefixIcon: const Icon(Icons.fingerprint,
                                color: aSecondaryColor),
                            labelStyle: const TextStyle(color: aSecondaryColor),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: const BorderSide(
                                    width: 2.0, color: aSecondaryColor))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: registrationController.passconfController,
                        decoration: InputDecoration(
                            label: const Text(aConfirm),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100)),
                            prefixIcon: const Icon(Icons.next_plan,
                                color: aSecondaryColor),
                            labelStyle: const TextStyle(color: aSecondaryColor),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: const BorderSide(
                                    width: 2.0, color: aSecondaryColor))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 1,
                        margin: const EdgeInsets.only(bottom: 3),
                        color: Colors.white70,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          title: const Text("Select Role"),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          trailing: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: false,
                              value: _selectedRole,
                              borderRadius: BorderRadius.circular(15),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedRole = newValue ?? _selectedRole;
                                  roleController.text =
                                      newValue ?? roleController.text;
                                });
                              },
                              items: <String>[
                                "User",
                                "Provider",
                                "Police",
                                "Admin"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              enableFeedback: true,
                              elevation: 0,
                              shape: const StadiumBorder(),
                              foregroundColor: aWhiteColor,
                              backgroundColor: aSecondaryColor,
                              side: const BorderSide(color: aSecondaryColor),
                              padding: const EdgeInsets.symmetric(
                                  vertical: aButtonHeight),
                            ),
                            onPressed: () async {
                              registrationController.registerUser();
                            },
                            child: Text(signUp.toUpperCase()),
                          )),
                      Column(
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const LogIn()));
                              },
                              child: Text.rich(TextSpan(children: [
                                TextSpan(
                                  text: aAlready,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                TextSpan(
                                  text: logIn,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ])))
                        ],
                      )
                    ],
                  )),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
