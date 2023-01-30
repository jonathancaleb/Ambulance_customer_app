import 'package:ambulance_app/src/views/BookingScreens/DriverOnTheWay.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class LookingForDRiverScreen extends StatefulWidget {
  const LookingForDRiverScreen({Key? key}) : super(key: key);

  @override
  _LookingForDRiverScreenState createState() => _LookingForDRiverScreenState();
}

class _LookingForDRiverScreenState extends State<LookingForDRiverScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SlidingUpPanel(
        maxHeight: screenHeight * 0.55,
        minHeight: screenHeight * 0.55,
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        panel: Expanded(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
                child: Center(
                  child: Image(
                    height: 300,
                    width: 300,
                    image: AssetImage('assets/pull_up_indicator.png'),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: SizedBox(
                        child: Image(
                          image: AssetImage('assets/bukk_logo_1.png'),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 0, bottom: 0, left: 10, right: 10),
                      child: Center(
                        child: Text(
                          "Ready To Move?",
                          style: TextStyle(
                            color: Color(0xff042B52),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.3,
                      width: screenWidth * 0.4,
                      child: Lottie.asset('assets/searching_animation.json'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 10, left: 10, right: 10),
                      child: SizedBox(
                        height: screenHeight * 0.06,
                        width: screenWidth * 0.7,
                        child: MaterialButton(
                          color: const Color(0xff042B52),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: const BorderSide(color: Colors.grey)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DriverOnTheWayScreen()));
                          },
                          child: const Text("Cancel",
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xffF1CA2D))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
