import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/schedule_controller.dart';

class DateTimePicker extends StatefulWidget {
  DateTimePicker({Key? key}) : super(key: key);

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  final scheduleController = Get.put(ScheduleController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
      child: SizedBox(
        height: screenHeight * 0.065,
        width: screenWidth * 0.15,
        child: MaterialButton(
          color: const Color(0xff042B52),
          onPressed: () {
            BottomPicker.dateTime(
              title: "Schedule Pick Up Date and time",
              titleStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
              onSubmit: (index) {
                var date = index;
                print(index);
              },
              onClose: () {
                // ignore: avoid_print
                print("Picker closed");
              },
              initialDateTime: getInitialScheduleDateTime(),
              iconColor: Colors.white,
              minDateTime: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, DateTime.now().hour),
              gradientColors: const [
                Color(0xff042B52),
                Color(0xff042B52),
              ],
            ).show(context);
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: Color(0xff042B52))),
          child: const Center(
            child: Icon(
              Icons.calendar_month_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  DateTime getInitialScheduleDateTime() {
    if (scheduleController.bookingScheduleDate.toString() ==
        DateTime.now().toString()) {
      return DateTime.now();
    } else {
      return scheduleController.bookingScheduleDate;
    }
  }
}
