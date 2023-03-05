import 'package:ambulance_app/src/controllers/hospital_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../constants/app_colors.dart';

class HospitalScreen extends StatelessWidget {
  HospitalController hospitalController = Get.put(HospitalController());
  // HospitalScreen({Key? key}) : super(key: key);

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
        title: Text("Hospitals", style: Theme.of(context).textTheme.headline4),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(LineAwesomeIcons.moon),
              color: aSecondaryColor)
        ],
      ),
      body: Obx(
        () => hospitalController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.black26,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),
              )
            : ListView.builder(
                itemCount:
                    hospitalController.responseModel?.facilities?.length ?? 0,
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text(hospitalController
                            .responseModel?.facilities![index].name ??
                        'no name'),
                    subtitle: Text(hospitalController
                            .responseModel?.facilities![index].address ??
                        'no address'),
                    trailing: Text(hospitalController
                            .responseModel?.facilities![index].phone ??
                        'no contact'),
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xff6ae792),
                      child: Text("H", style: TextStyle(color: Colors.black)),
                    ),
                  );
                })),
      ),
    );
  }
}
