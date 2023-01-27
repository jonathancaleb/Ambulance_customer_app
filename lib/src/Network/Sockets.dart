import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class Sockets {
  Sockets() : super() {
    _handleSocketConnection();
  }
  // factory Sockets() => _instance;

  // Sockets._internal();

  // static final _instance = Sockets._internal();

  IOWebSocketChannel? channel;

  Stream<dynamic>? get streams => channel?.stream;

  void _handleSocketConnection() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    String? token = _preferences.getString('access_token');

    channel = IOWebSocketChannel.connect(
        Uri.parse('wss://dev-dispatch.bukkhl.work/v1/ws/customer/'),
        headers: {
          'Authorization': 'Token $token',
        });
  }

  void sendPayload(Map<String, dynamic> data) {
    channel?.sink.add(data);
  }

  void close() {
    channel?.sink.close(status.goingAway);
  }
}

// final channel = WebSocketChannel.connect(
//   Uri.parse('wss://echo.websocket.events'),
// );

// final driverController = Get.put(DriverController());

// void openSocketConnection() {
//   channel.stream.listen(
//     (data) {
//       print(data);
//       //TODO: add incoming data to the  driver controller
//       updateDriverController(data);
//     },
//     onError: (error) => print(error),
//   );
// }

// void updateDriverController(data) {
//   //Update the vehicle and driver details
//   //driverController.updateDriverName("John Doe");
//   //driverController.updateVehicleNumberPlate("UAA 123F");
//   driverController.updateDriverLocation(1.200333, 12.222134);

//   // if (data == "Driver matched") {
//   //   driverController.updateBookingStage(data.toString());
//   //   showDriverMatchedNotification();
//   // }
//   // if (data == "Driver has reached") {
//   //   driverController.updateBookingStage(data.toString());
//   //   showDriverHasArrivedNotification();
//   // }
//   // if (data == "Trip Started") {
//   //   driverController.updateBookingStage(data.toString());
//   //   showTripStartedNotification();
//   // }
//   // if (data == "Trip Completed") {
//   //   driverController.updateBookingStage(data.toString());
//   //   showTripCompletedNotification();
//   // }

//   print(driverController.vehicleNumberPlate);
// }

// void closeSocketConnection() {
//   channel.sink.close();
// }

// void sendDataToSocket(String data) {
//   channel.sink.add(data);
// }

// void triggerSocketSimulation() async {
//   for (var i = 0; i < 4; i++) {
//     await Future.delayed(const Duration(seconds: 10));

//     if (i == 0) {
//       sendDataToSocket("Driver matched");
//       //driverController.updateData("Driver Matched");
//     }
//     if (i == 1) {
//       sendDataToSocket("Driver has reached");
//       //driverController.updateData("Driver has reached");
//     }
//     if (i == 2) {
//       //driverController.updateData("Trip started");
//       sendDataToSocket("Trip Started");
//     }
//     if (i == 3) {
//       sendDataToSocket("Trip Completed");
//       //driverController.updateData("Trip Completed");
//     }
//   }
// }
