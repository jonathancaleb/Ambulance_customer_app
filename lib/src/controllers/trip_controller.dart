import 'dart:convert';

import 'package:ambulance_app/src/controllers/map_controller.dart';
import 'package:get/get.dart';

import '../Network/Sockets.dart';
import '../models/driver_data_model.dart';
import '../Notifications/booking_notifications.dart';
import '../controllers/DriverController.dart';
import '../models/trip_model.dart';

//Define the driver controller
final driverController = Get.put(DriverController());

class TripController extends GetxController {
  //Dispatch events
  static const String driverMatchedEvent = "driver-matched";
  static const String driverReachedPickUpEvent = "driver-reached-pickup";
  static const String tripStartedEvent = "trip-started";
  static const String tripCompletedEvent = "trip-completed";

  //TripModel instance
  TripModel? tripModel;

  Sockets sockets = Sockets();

  void listenToSocketsEvents() {
    sockets.streams?.listen(
      (event) async {
        print('Socket Event: $event');
        print("Socket is open");
        //
        // (event['type'] == 'notification') {
        if (event['type'] == 'driver-location') {
          //get the driver data from event and pass it to map controller
          final driverData = jsonDecode(event);
          getxMapController
              .updateDriverLocation(DriverDataModel.fromJson(driverData));
        } else {
          // switch types
          switch (event['type']) {
            case driverMatchedEvent:
              // create trip model and emit
              tripModel = TripModel.fromJson(Map.from(event));
              driverController.updateDriverInformation(
                  event["data"]["driver_name"],
                  event["data"]["vehicle_numberplate"],
                  event["data"]["driver_picture"],
                  event["data"]["driver_phone_number"]);
              driverController.updateBookingStage(event["data"]["text"]);
              sendBookingStageNotification(event["data"]["text"]);
              break;
            case driverReachedPickUpEvent:
              // create trip model and emit
              driverController.updateBookingStage(event["data"]["text"]);
              sendBookingStageNotification(event["data"]["text"]);
              break;
            case tripStartedEvent:
              // create trip model and emit
              driverController.updateBookingStage(event["data"]["text"]);
              sendBookingStageNotification(event["data"]["text"]);
              break;
            case tripCompletedEvent:
              // create trip model and emit
              driverController.updateBookingStage(event["data"]["text"]);
              sendBookingStageNotification(event["data"]["text"]);
              break;
            default:
          }
        }
      },
      onError: wserror,
      onDone: reconnect,
    );
  }

  reconnect() async {
    print('socket has ended');
    // add(LoadTripEvent());
  }

  wserror(err) async {
    print('socket had error ' + err.toString());
    await reconnect();
  }
}
