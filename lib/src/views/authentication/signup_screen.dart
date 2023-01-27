import 'package:ambulance_app/src/constants/app_colors.dart';
import 'package:ambulance_app/src/constants/sizes.dart';
import 'package:ambulance_app/src/constants/text_string.dart';
import 'package:ambulance_app/src/widgets/form_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(aDefaultSize),
            child: Column(children: [
              const FormHeaderWidget(
                  title: aSignupTitle, subTitle: aSignupDescription),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
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
                    /*Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        items: <String>['Admin', 'Patient', 'Driver', 'Police']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _role,
                        hint: const Text("Select a Role"),
                        onChanged: (value) => setState(() => _role = value),
                      ),
                    ),*/
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const StadiumBorder(),
                            foregroundColor: aWhiteColor,
                            backgroundColor: aSecondaryColor,
                            side: const BorderSide(color: aSecondaryColor),
                            padding: const EdgeInsets.symmetric(
                                vertical: aButtonHeight),
                          ),
                          child: Text(signUp.toUpperCase()),
                        )),
                    Column(
                      children: [
                        TextButton(
                            onPressed: () {},
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
    );
  }
}
