import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../constants/app_colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/sizes.dart';
import '../../constants/text_string.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left),
            color: aSecondaryColor),
        title: Text(aEdit, style: Theme.of(context).textTheme.headline4),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const Image(image: AssetImage(aAccount)))),
                  Positioned(
                    bottom: 5,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: aPrimaryColor),
                          child: const Icon(LineAwesomeIcons.camera,
                              size: 20.0, color: Colors.black)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                  child: Column(
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
                        label: const Text(aEmail),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        prefixIcon: const Icon(Icons.email_outlined,
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
                        label: const Text(aPhone),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        prefixIcon:
                            const Icon(Icons.phone, color: aSecondaryColor),
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
                    height: 30,
                  ),
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
                        child: const Text(aUpdate)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text.rich(
                        TextSpan(
                          text: ajoined,
                          style: TextStyle(fontSize: 12),
                          children: [
                            TextSpan(
                                text: ajoinedat,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12))
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.redAccent.withOpacity(0.1),
                              elevation: 0,
                              foregroundColor: Colors.red,
                              shape: const StadiumBorder(),
                              side: BorderSide.none),
                          child: const Text(adelete))
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
