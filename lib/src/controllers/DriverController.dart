// ignore: file_names
import 'dart:convert';

import 'package:get/get.dart';

import '../Network/Sockets.dart';
import '../Notifications/booking_notifications.dart';
import '../constants/Constants.dart';
import '../models/driver_data_model.dart';
import '../models/trip_model.dart';
import 'map_controller.dart';
import 'nav_controller.dart';

final navController = Get.put(NavController());

class DriverController extends GetxController {
  DriverController() : super() {
    listenToSocketsEvents();
  }
  var bookingStage = "Ready To Move".obs;
  String driverName = "John Doe";
  String vehicleNumberPlate = "UAA 123F";
  String driverPicture = Constants.placeHolderUserImage;
  String driverPhoneNumber = "";
  double amount = 0;
  double distance = 0;
  String currency = "";

  double driverLat = 0.0;
  double driverLong = 0.0;

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
        //
        if (event['type'] == 'notification') {
          // switch types
          switch (event['title']) {
            case driverMatchedEvent:
              // create trip model and emit
              tripModel = TripModel.fromJson(Map.from(event));
              //TODO: implement update trip screen with the dispatch
              updateDriverInformation(
                tripModel?.driverName ?? '',
                tripModel?.driverPhoneNumber ?? '',
                tripModel?.driverPicture ?? '',
                tripModel?.driverPhoneNumber ?? '',
              );
              updateBookingStage(event["data"]["text"]);
              sendBookingStageNotification(event["data"]["text"]);
              break;
            case driverReachedPickUpEvent:
              // create trip model and emit
              sendBookingStageNotification(event["data"]["text"]);
              break;
            case tripStartedEvent:
              // create trip model and emit
              sendBookingStageNotification(event["data"]["text"]);
              break;
            case tripCompletedEvent:
              // create trip model and emit
              sendBookingStageNotification(event["data"]["text"]);

              /// call
              navController.navigateToPosition(3);
              break;
            default:
          }
        } else if (event['type'] == 'driver-location') {
          //get the driver data from event and pass it to map controller
          final driverData = jsonDecode(event);
          getxMapController
              .updateDriverLocation(DriverDataModel.fromJson(driverData));
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

  //update driver information
  void updateDriverInformation(
    String name,
    String vehiclNumberPlate,
    String picture,
    String phoneNumber,
  ) {
    driverName = name;
    vehicleNumberPlate = vehiclNumberPlate;
    driverPicture = picture;
    driverPhoneNumber = phoneNumber;
    update();
  }

  //updates the controller with the new booking stage
  void updateBookingStage(String newBookingStage) {
    bookingStage = newBookingStage as RxString;
    update();
  }

  void updateDriverLocation(double lat, double long) {
    driverLat = lat;
    driverLong = long;
    update();
  }

  void updateAmount(double newAmount) {
    amount = newAmount;
    update();
  }

  void updateDistance(double newDistance) {
    distance = newDistance;
    update();
  }

  void updateCurrency(String currency) {
    currency = currency;
    update();
  }

  ///
  /// Handle the trip cancel action here
  ///
  void cancelTrip() {}
}
