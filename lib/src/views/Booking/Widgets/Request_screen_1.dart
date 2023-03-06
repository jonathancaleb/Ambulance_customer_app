import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/RequestController.dart';
import '../../../controllers/map_controller.dart';
import '../../../controllers/nav_controller.dart';
import '../../places/places_search_view.dart';

class FirstBookingScreen extends StatefulWidget {
  const FirstBookingScreen({Key? key}) : super(key: key);

  @override
  State<FirstBookingScreen> createState() => _FirstBookingScreenState();
}

class _FirstBookingScreenState extends State<FirstBookingScreen> {
  //Inject get controller into home widget
  final bookingController = Get.put(RequestController());
  final navController = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Container(
        //   height: 30,
        //   width: screenWidth,
        //   color: const Color(0xff042B52),
        //   child: const Center(
        //     child: Text(
        //       "How can we move you today?",
        //       style: TextStyle(color: Color(0xffF1CA2D), fontFamily: "Poppins"),
        //     ),
        //   ),
        // ),

        // Location card
        Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: screenWidth * 0.9,
              height: screenHeight * 0.1,
              child: Center(
                child: InkWell(
                  onTap: () {
                    showBottomSheet(
                      context: context,
                      elevation: 500,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return PlacesSearchView(
                          title: 'Destination Location',
                          placeholder: 'Search Destination...',
                          countryCode: getxMapController.currentCountryCode,
                          onPlaceSelect: (detail) {
                            // getxMapController.updateDeliveryAddress(
                            //   detail?.label ?? 'No address selected',
                            // );
                            // getxMapController
                            //     .updateDestinationLatitudelongitude(
                            //   detail?.label ?? 'No address selected',
                            // );

                            getxMapController.setDestinationLatLng(
                              lat: detail!.lat,
                              lng: detail.long,
                              address: detail.label ?? 'No address selected',
                            );

                            if ((getxMapController.startAddress != "" &&
                                getxMapController.destinationAddress != "")) {
                              if (getxMapController.markers.isNotEmpty) {
                                getxMapController.markers.clear();
                              }
                              if (getxMapController.polylines.isNotEmpty) {
                                getxMapController.polylines.clear();
                              }
                              if (getxMapController
                                  .polylineCoordinates.isNotEmpty) {
                                getxMapController.polylineCoordinates.clear();
                              }
                              getxMapController.calculateDistance();
                            }

                            // update position

                            Navigator.of(context).pop();
                          },
                        );
                      },
                    );
                    // setState(() {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) =>
                    //               const EditDEliveryLocation()));
                    // });
                  },
                  child: Container(
                    height: 50,
                    width: screenWidth * 0.9,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      color: const Color(0xff646464).withOpacity(.1),
                      // color: Colors.grey[350],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 40,
                            height: 50,
                            child: Icon(
                              Icons.location_pin,
                              color: Color(0xFFEF9A9A),
                            ),
                          ),
                          GetBuilder<MapController>(
                            builder: (_) => Flexible(
                              fit: FlexFit.tight,
                              child: Text(
                                  getxMapController
                                      .getDeliveryLocationAddress(),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Location area

            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                height: screenHeight * 0.07,
                width: screenWidth * 0.7,
                child: MaterialButton(
                  color: const Color(0xFFEF9A9A),
                  disabledColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    navController.addToBookingPosition();
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
