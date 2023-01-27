import 'dart:convert';

import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Notifications/booking_notifications.dart';
import '../constants/constants.dart';
import '../controllers/DriverController.dart';

//Dispatch events
const String driverMatchedEvent = "driver-matched";
const String driverReachedPickUpEvent = "driver-reached-pickup";
const String tripStartedEvent = "trip-started";
const String tripCompletedEVent = "trip-completed";

//Define web socket channel
Uri socketEndPoint = Uri.parse(Constants.dispatchWebSocketEndPoint);
final channel = WebSocketChannel.connect(socketEndPoint);

//Define the driver controller
final driverController = Get.put(DriverController());

//Open the web socket connection
void openDispatchSocketConnection() {
  channel.stream.listen((data) {
    print(data);
    updateDriverController(data);
  }, onError: (error) => print(error));
}

//Load the dispatch data into the driver Controller
void updateDriverController(dynamic data) {
  try {
    var dispatchData = jsonDecode(data);

    //Check for the driver match event
    if (dispatchData["title"] == driverMatchedEvent) {
      driverController.updateDriverInformation(
          dispatchData["data"]["driver_name"],
          dispatchData["data"]["vehicle_numberplate"],
          dispatchData["data"]["driver_picture"],
          dispatchData["data"]["driver_phone_number"]);
      driverController.updateBookingStage(dispatchData["data"]["text"]);
      sendBookingStageNotification(dispatchData["data"]["text"]);
    }

    if (dispatchData["title"] == driverReachedPickUpEvent) {
      driverController.updateBookingStage(dispatchData["data"]["text"]);
      sendBookingStageNotification(dispatchData["data"]["text"]);
      sendBookingStageNotification(dispatchData["data"]["text"]);
    }

    if (dispatchData["title"] == tripStartedEvent) {}
    driverController.updateBookingStage(dispatchData["data"]["text"]);
    if (dispatchData["title"] == tripCompletedEVent) {
      driverController.updateBookingStage(dispatchData["data"]["text"]);
      sendBookingStageNotification(dispatchData["data"]["text"]);
    }
  } catch (e) {
    print(e.toString());
  }
}

void closeSocketConnectopn() {
  channel.sink.close();
}
