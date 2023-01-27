import 'dart:async';
import 'package:bukk_customer_app/views/BookingScreens/DriverRatingScreen.dart';
import 'package:bukk_customer_app/views/widgets/cancel_trip_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TripStartedScreen extends StatefulWidget {
  const TripStartedScreen({Key? key}) : super(key: key);

  @override
  State<TripStartedScreen> createState() => _TripStartedScreenState();
}

class _TripStartedScreenState extends State<TripStartedScreen> {
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
                            currentStep: 4,
                            selectedColor: Color(0xffF1CA2D),
                          ),
                        ),
                        Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "We are busy moving!",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Regular",
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
                    "Time to Delivery - 04:20",
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
                          onPressed: () => launchUrlString('tel:23239233'),
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
                          Stack(
                            children: [
                              Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xff7c94b6),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'http://i.imgur.com/QSev0hg.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff042B52),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Text(
                                    '4.9',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Driver Name",
                              style: TextStyle(
                                  color: Color(0xff042B52), fontSize: 16),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
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
                        onPressed: () => launchUrlString('sms:23239233'),
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
                    //Go to Trip Started Screen
                    showDialog(
                        context: context,
                        builder: (context) =>
                            CancelTripDialog(cancelTrip: (cancel) {
                              switch (cancel) {
                                case true:
                                  //TODO: handle trip cancelled.
                                  return;
                                case false:
                                  return;
                              }
                            }));
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const RatingScreen(),
                    //   ),
                    // );
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
