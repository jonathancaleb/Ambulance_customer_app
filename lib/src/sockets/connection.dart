import 'dart:convert';
import 'dart:io';

import 'package:bukk_customer_app/controllers/map_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

import '../Notifications/booking_notifications.dart';
import '../controllers/DriverController.dart';
import '../models/driver_data_model.dart';
import '../models/trip_model.dart';

class SocketManager {
  //Web socket channel
  IOWebSocketChannel? channel;

  //TripModel instance
  TripModel? tripModel;

  Stream<dynamic>? get streams => channel?.stream;

  ///
  ///Socket connection flag
  ///
  bool isConnected = false;

  //Dispatch events
  static const String driverMatchedEvent = "driver-matched";
  static const String driverReachedPickUpEvent = "driver-reached-pickup";
  static const String tripStartedEvent = "trip-started";
  static const String tripCompletedEvent = "trip-completed";

  //injection the controllers
  final getxMapController = Get.put(MapController());
  final driverController = Get.put(DriverController());

  void initSocketConnection() async {
    ///
    ///open a new WebSocket Connection
    ///
    try {
      ///
      /// Just in case, close any previous connections
      ///
      reset();

      ///
      ///get access token
      ///
      //Get the access token
      final SharedPreferences _preferences =
          await SharedPreferences.getInstance();

      String accessToken = _preferences.getString('access_token').toString();

      channel = IOWebSocketChannel.connect(
          // Uri.parse(
          //     "wss://demo.piesocket.com/v3/channel_1?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self"),
          Uri.parse("wss://dev-dispatch.bukkhl.work/v1/ws/customer/ "),
          headers: {
            'Authorization': 'Token $accessToken',
          });

      //connectToSocket(accessToken);
      try {
        channel?.stream.listen(
          (data) {
            print(data);
            //set flag
            isConnected = true;
            print("Web socket connection: $isConnected");
            print(data.toString());
          },
          onError: (error) => print(error.toString()),
        );
      } catch (e) {
        print(e.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void connectToSocket(String accessToken) {
    try {
      channel?.stream.listen(
        (data) {
          print(data);
          //set flag
          isConnected = true;
          print("Web socket connection: $isConnected");
          print(data.toString());
        },
        onError: (error) => print(error.toString()),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void closeSocketConnection() {
    isConnected = false;
    channel?.sink.close();
  }

  void sendDataTosocket(String data) {
    channel?.sink.add(data);
  }

  void reset() {
    if (channel != null) {
      channel?.sink.close();
      isConnected = false;
    }
  }

  bool getSocketConnectionstatus() {
    return isConnected;
  }

  void reConnectWebSocket() async {
    try {
      //check if the socket is open
      if (isConnected) {
        print("Socket Connection is active.....");
        return;
      } else {
        print("Socket Connection is down.....");
        print("Attempting reconnection.....");
        channel?.stream.listen(
          (event) {
            //set flag
            isConnected = true;
            print(event);
            parseDataFromSocket(event);
          },
          onError: (error) => print(error.toString()),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // decode socket event data and update the controllers.
  void parseDataFromSocket(dynamic event) {
    try {
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
    } catch (e) {
      print(e.toString());
    }
  }
}
