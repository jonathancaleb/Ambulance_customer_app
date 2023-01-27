import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';

class BuildProfileWidget extends StatefulWidget {
  const BuildProfileWidget({Key? key}) : super(key: key);

  @override
  State<BuildProfileWidget> createState() => _BuildProfileWidgetState();
}

class _BuildProfileWidgetState extends State<BuildProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 25,
        // ignore: sized_box_for_whitespace
        child: Container(
            width: Get.width,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      elevation: 0,
                      foregroundColor: aSecondaryColor,
                      backgroundColor: aWhiteColor,
                      //side: const BorderSide(),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onPressed: () => Get.back(),
                    child: const Icon(Icons.close),
                  ),
                ])));
  }
}
