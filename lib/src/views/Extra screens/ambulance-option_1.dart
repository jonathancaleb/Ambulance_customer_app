import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_string.dart';

class AmbulanceOption1 extends StatelessWidget {
  const AmbulanceOption1({Key? key}) : super(key: key);

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
        title: Text(aProfile, style: Theme.of(context).textTheme.headline4),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(LineAwesomeIcons.moon),
              color: aSecondaryColor)
        ],
      ),
      body: Container(
        child: const Text("ambulance option 1"),
      ),
    );
  }
}
