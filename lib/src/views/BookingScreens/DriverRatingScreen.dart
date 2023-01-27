import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
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
          maxHeight: screenHeight * 0.65,
          minHeight: screenHeight * 0.6,
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
                            currentStep: 5,
                            selectedColor: Color(0xffF1CA2D),
                          ),
                        ),
                        Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Share your Experience with us!",
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
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
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
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Driver Name",
                              style: TextStyle(
                                  color: Color(0xff042B52), fontSize: 16),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "xyz 182",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Rate Your Driver",
                              style: TextStyle(
                                  color: Color(0xff042B52),
                                  fontSize: 16,
                                  fontFamily: "Regular",
                                  fontWeight: FontWeight.normal),
                            ),
                          ),

                          //New rating widget
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                              //TODO: post rating to ratings endpoint
                            },
                          ),

                          //Tipping widget

                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Enjoyed the service? Leave a tip.",
                              style: TextStyle(
                                  color: Color(0xff042B52),
                                  fontSize: 16,
                                  fontFamily: "Regular",
                                  fontWeight: FontWeight.normal),
                            ),
                          ),

                          //Tipping area
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    width: 55,
                                    height: 55,
                                    child: MaterialButton(
                                      color: Colors.grey[400],
                                      onPressed: () {},
                                      child: const Text(
                                        "0%",
                                        style: TextStyle(
                                          color: Color(0xff042B52),
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Regular",
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 55,
                                    height: 55,
                                    child: MaterialButton(
                                      color: Colors.grey[400],
                                      onPressed: () {},
                                      child: const Text(
                                        "5%",
                                        style: TextStyle(
                                          color: Color(0xff042B52),
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Regular",
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    width: 55,
                                    height: 55,
                                    child: MaterialButton(
                                      color: Colors.grey[400],
                                      onPressed: () {},
                                      child: const Text(
                                        "10%",
                                        style: TextStyle(
                                          color: Color(0xff042B52),
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Regular",
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    width: 55,
                                    height: 55,
                                    child: MaterialButton(
                                      color: Colors.grey[400],
                                      onPressed: () {},
                                      child: const Text(
                                        "15%",
                                        style: TextStyle(
                                          color: Color(0xff042B52),
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Regular",
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    width: 55,
                                    height: 55,
                                    child: MaterialButton(
                                      color: Colors.grey[400],
                                      onPressed: () {},
                                      child: const Text(
                                        "20%",
                                        style: TextStyle(
                                          color: Color(0xff042B52),
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Regular",
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),

                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 5, left: 10, right: 10),
                            child: SizedBox(
                              height: screenHeight * 0.07,
                              width: screenWidth * 0.7,
                              child: MaterialButton(
                                color: const Color(0xff042B52),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(color: Colors.grey)),
                                onPressed: () {
                                  //TODO: shown thank you dialog and go to home screen
                                },
                                child: const Text("Submit",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xffF1CA2D))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
