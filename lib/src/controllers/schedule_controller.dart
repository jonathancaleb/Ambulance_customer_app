import 'package:get/get.dart';

class ScheduleController extends GetxController {
  DateTime bookingScheduleDate = DateTime.now();

  updateBookingScheduleDate(DateTime date) {
    bookingScheduleDate = date;
    update();
  }
}
