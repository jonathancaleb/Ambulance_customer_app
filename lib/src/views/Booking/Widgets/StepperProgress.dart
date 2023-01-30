import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../controllers/DriverController.dart';
import '../../../controllers/nav_controller.dart';

class StepProgress extends StatefulWidget {
  const StepProgress({Key? key}) : super(key: key);

  @override
  State<StepProgress> createState() => _StepProgressState();
}

class _StepProgressState extends State<StepProgress> {
  final navController = Get.put(NavController());
  final driverController = Get.put(DriverController());

  late int stepPosition;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Center(
          child: SizedBox(
            height: 65,
            width: screenWidth,
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 5, right: 8, left: 8),
                    child: Obx(
                      () => StepProgressIndicator(
                        totalSteps: 5,
                        currentStep: navController.stepProgress.toInt() < 1
                            ? 1
                            : navController.stepProgress.toInt(),
                        selectedColor: const Color(0xffF1CA2D),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () => Text(
                            driverController.bookingStage.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff042B52),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
