import 'dart:async';
import 'package:ambulance_app/src/views/BookingScreens/TripStartedScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DriverOnTheWayScreen extends StatefulWidget {
  const DriverOnTheWayScreen({Key? key}) : super(key: key);

  @override
  State<DriverOnTheWayScreen> createState() => _DriverOnTheWayScreenState();
}

class _DriverOnTheWayScreenState extends State<DriverOnTheWayScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const _initialCameraPosition = CameraPosition(
      target: LatLng(37.43296265331129, -122.08832357078792), zoom: 11.5);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SlidingUpPanel(
          maxHeight: screenHeight * 0.5,
          minHeight: screenHeight * 0.5,
          body: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Positioned.fill(
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _initialCameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 60,
                  width: screenWidth,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: StepProgressIndicator(
                            totalSteps: 5,
                            currentStep: 3,
                            selectedColor: Color(0xffF1CA2D),
                          ),
                        ),
                        Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Driver is on the way!",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.bold,
                              color: Color(0xff042B52),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          panel: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: screenWidth,
                color: Colors.grey.shade300,
                child: const Center(
                  child: Text(
                    "Time to Arrival - 04:20",
                    style: TextStyle(
                      color: Color(0xff042B52),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: MaterialButton(
                          onPressed: () {},
                          child: const Icon(
                            Icons.phone,
                            color: Color(0xff042B52),
                          ),
                          shape: const CircleBorder(
                            side: BorderSide(
                              color: Color(0xff042B52),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: const Color(0xff7c94b6),
                              image: const DecorationImage(
                                image: NetworkImage(
                                    'http://i.imgur.com/QSev0hg.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                              border: Border.all(
                                color: const Color(0xff042B52),
                                width: 4.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Driver Name",
                              style: TextStyle(
                                  color: Color(0xff042B52), fontSize: 16),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "xyz 182",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.mail,
                          color: Color(0xff042B52),
                        ),
                        shape: const CircleBorder(
                          side: BorderSide(
                            color: Color(0xff042B52),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  onPressed: () {
                    // //Go to Trip Started Screen
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TripStartedScreen()));
                  },
                  child: const Text(
                    "Cancel Ride...",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xffF1CA2D),
                        fontFamily: "Regular"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
