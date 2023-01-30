import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/Constants.dart';
import '../../services/authService.dart';
import '../authentication/signup_screen.dart';
import 'file_bottom_modal.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitched = true;
  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNUmber = "";
  String fullName = "";
  File? image;

  @override
  void initState() {
    getProfileData();

    super.initState();
  }

  void getProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    firstName = prefs.getString("firstName").toString();
    lastName = prefs.getString("lastName").toString();
    email = prefs.getString("email").toString();
    phoneNUmber = prefs.getString("phoneNumber").toString();
    fullName = firstName + " " + lastName;
    setState(() {});
  }

  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (contextT) => FileBottomModal(
        onCameraTap: (file) {
          Navigator.of(contextT).pop();
          image = file;
          setState(() {});
        },
        onFolderTap: (file) {
          Navigator.of(contextT).pop();
          image = file;
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    //getProfileData();

    return Container(
        alignment: Alignment.topCenter,
        color: Colors.grey.withOpacity(0.05),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width,
                margin: const EdgeInsets.only(
                  top: 10,
                ),
                decoration: const BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xff042B52),
                              width: 3.0,
                            ),
                          ),
                          child: Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xff7c94b6),
                              image: image != null
                                  ? DecorationImage(
                                      image: FileImage(image!),
                                      fit: BoxFit.cover,
                                    )
                                  : const DecorationImage(
                                      image: NetworkImage(
                                          Constants.placeHolderUserImage),
                                      fit: BoxFit.cover,
                                    ),
                              border: Border.all(
                                color: Colors.white,
                                width: 3.0,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xff042B52),
                                  shape: BoxShape.circle),
                              child: IconButton(
                                padding: const EdgeInsets.all(0),
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.yellow,
                                  size: 20,
                                ),
                                onPressed: _showImagePickerDialog,
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      fullName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: "Regular",
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      phoneNUmber,
                      style: TextStyle(
                        color: Colors.grey.withOpacity(0.5),
                        fontFamily: "Regular",
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                margin: const EdgeInsets.only(
                  top: 10,
                ),
                decoration: const BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 1,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Full Name",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Regular",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                fullName,
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.5),
                                  fontFamily: "Regular",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.arrow_right,
                                color: Color(0xffF1CA2D),
                                size: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      height: 1.5,
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 15, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Email Address",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Regular",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                email,
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.5),
                                  fontFamily: "Regular",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Icon(
                                Icons.arrow_right,
                                color: Color(0xffF1CA2D),
                                size: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      height: 1.5,
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 15, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.phone_android,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Mobile Number",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Regular",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                phoneNUmber,
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.5),
                                  fontFamily: "Regular",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Icon(
                                Icons.arrow_right,
                                color: Color(0xffF1CA2D),
                                size: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   width: width,
                    //   height: 1.5,
                    //   color: Colors.grey.withOpacity(0.1),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 20, right: 20, bottom: 15, top: 15),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: const [
                    //           Icon(
                    //             Icons.lock,
                    //             color: Colors.grey,
                    //           ),
                    //           SizedBox(
                    //             width: 10,
                    //           ),
                    //           Text(
                    //             "Update Password",
                    //             style: TextStyle(
                    //               color: Colors.black,
                    //               fontFamily: "Regular",
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w600,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.end,
                    //         children: [
                    //           Text(
                    //             "",
                    //             style: TextStyle(
                    //               color: Colors.grey.withOpacity(0.5),
                    //               fontFamily: "Regular",
                    //               fontSize: 12,
                    //             ),
                    //           ),
                    //           const SizedBox(
                    //             width: 3,
                    //           ),
                    //           const Icon(
                    //             Icons.arrow_right,
                    //             color: Color(0xffF1CA2D),
                    //             size: 30,
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      width: width,
                      height: 1.5,
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                margin: const EdgeInsets.only(
                  top: 10,
                ),
                decoration: const BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 1,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.notifications,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Notification",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Regular",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                print(isSwitched);
                              });
                            },
                            activeTrackColor: const Color(0xffF1CA2D),
                            activeColor: const Color(0xff042B52),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: SizedBox(
                          width: width / 3.5,
                          child: MaterialButton(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: 150,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          const Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: Text(
                                                'Are you sure you want to log out?'),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: SizedBox(
                                                  height: height * 0.07,
                                                  width: width * 0.3,
                                                  child: MaterialButton(
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                      side: const BorderSide(
                                                        color:
                                                            Color(0xff042B52),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Center(
                                                      child: Center(
                                                        child: Text(
                                                          "No",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Regualar",
                                                            color: Color(
                                                                0xff042B52),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: SizedBox(
                                                  height: height * 0.07,
                                                  width: width * 0.3,
                                                  child: MaterialButton(
                                                    color:
                                                        const Color(0xff042B52),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        side: const BorderSide(
                                                            color: Color(
                                                                0xff042B52))),
                                                    onPressed: () {
                                                      logout().then((value) => {
                                                            if (value)
                                                              {
                                                                Navigator.pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const SignUp()))
                                                              }
                                                            else
                                                              {
                                                                // //TODO: show snack feedback for failed out operation
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        const SnackBar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  content: Text(
                                                                      "Logout failed"),
                                                                ))
                                                              }
                                                          });
                                                    },
                                                    child: const Center(
                                                      child: Center(
                                                        child: Text(
                                                          "Yes",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Regualar",
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            color: const Color(0xff042B52),
                            child: const Text(
                              "Log Out",
                              style: TextStyle(
                                color: Color(0xffF1CA2D),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
