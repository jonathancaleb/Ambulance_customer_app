import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../controllers/RequestController.dart';
import '../../controllers/map_controller.dart';
import '../../controllers/nav_controller.dart';
import '../../services/api_service.dart';
import '../places/places_search_view.dart';
import 'Widgets/date_time_picker.dart';

class PlaceBookingScreen extends StatefulWidget {
  const PlaceBookingScreen({Key? key, required this.controller})
      : super(key: key);
  final PanelController controller;

  @override
  State<PlaceBookingScreen> createState() => PlaceBookingScreenState();
}

class PlaceBookingScreenState extends State<PlaceBookingScreen>
    with SingleTickerProviderStateMixin {
  final bookingController = Get.put(RequestController());
  final navController = Get.put(NavController());
  var currentDateTime = DateTime.now();
  //Vehicle size card index
  int vehicleCardIndex = -1;

  //Thousands Formatter
  NumberFormat myFormat = NumberFormat('#,##,000');

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      // print('SCROLLING: ${_scrollController.offset}');
      if (_scrollController.offset >= 15) {
        widget.controller.open();
      }

      if (_scrollController.offset <= 1.5) {
        widget.controller.close();
        // _cardController?.fling(velocity: -1.0);
      }
    });
    super.initState();
  }

  void setPlaceBookingScreenState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.9,
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            //Location pin card
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                color: const Color(0xFFEF9A9A),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Location icons column
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.circle,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: Image(
                              image: Svg("assets/location_dotted_line.svg"),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.location_pin,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                      //Location fields column
                      SizedBox(
                        width: screenWidth * 0.75,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Pick up location Field
                            _buildPickupField(context),

                            //Delivery Location Field
                            _buildDeliveryLocationField(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //Vehicle Capacity Label
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Emergency?",
                  style: TextStyle(
                    color: Color(0xff042B52),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Medical Personnel will get in touch shortly",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 2.0, bottom: 8.0),
              child: Center(
                child: Text(
                  "Payments",
                  style: TextStyle(
                    color: Color(0xff042B52),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            /// TODO add a payment method drop down list
            SizedBox(
              // height: screenHeight * 0.086,
              height: 70,
              width: screenWidth * 0.9,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: InkWell(
                  onTap: () {
                    //TODO: open payment bottom Sheet
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10.0),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return _buildPaymentOptionBottomSheet(
                              screenHeight: screenHeight,
                              screenWidth: screenWidth);
                        });
                  },
                  child: Card(
                    color: Colors.white,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(10),
                    //   color: Colors.grey[350],
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Image(
                            image: AssetImage('assets/visa_master.png'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "*** **** **** 4582",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xff000000),
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //Place Booking Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 5, right: 5),
                      child: SizedBox(
                        height: screenHeight * 0.065,
                        width: screenWidth * 0.15,
                        child: MaterialButton(
                          color: const Color(0xFFEF9A9A),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: const BorderSide(color: Color(0xFFEF9A9A))),
                          onPressed: () {
                            navController.subtractFromBookingPosition();
                          },
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: const [
                              Positioned(
                                left: -12,
                                child: Icon(
                                  Icons.arrow_left,
                                  color: Color(0xff000000),
                                  size: 45,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const DateTimePicker(),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 5, left: 5, right: 10),
                      child: SizedBox(
                        height: screenHeight * 0.065,
                        width: screenWidth * 0.45,
                        child: MaterialButton(
                          color: const Color(0xFFEF9A9A),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(
                                color: Color(0xFFEF9A9A),
                              )),
                          onPressed: () {
                            submitBookingRequest();
                          },
                          child: const Text(
                            "Let's Move!",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showMatchingFailedDialog(
      BuildContext context, double screenHeight, double screenWidth) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.0),
          ),
        ),
        context: context,
        builder: (context) {
          return SizedBox(
            height: screenHeight * 0.35,
            width: screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "We couldn't match you with a driver!",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  //s height: screenHeight * 0.3,
                  width: screenWidth * 0.4,
                  child: const Image(
                    image: AssetImage('assets/failed.png'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.4,
                        child: MaterialButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(
                              color: Color(0xFFEF9A9A),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Center(
                            child: Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Color(0xFFEF9A9A),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.4,
                        child: MaterialButton(
                          color: const Color(0xFFEF9A9A),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: const BorderSide(color: Color(0xFFEF9A9A))),
                          onPressed: () {
                            //TODO: Call submit booking request
                          },
                          child: const Center(
                            child: Center(
                              child: Text(
                                "Retry",
                                style: TextStyle(
                                    fontFamily: "Poppins", color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  InkWell _buildPickupField(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectPickupLocation(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  "Confirm pickup location",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Color(0xff000000),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GetBuilder<MapController>(
                    builder: (_) => Flexible(
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                              right: 8.0,
                            ),
                            child: Text(
                              getxMapController.currentAddress,
                              style: const TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  PersistentBottomSheetController<dynamic> _selectPickupLocation(
      BuildContext context) {
    return showBottomSheet(
      context: context,
      elevation: 500,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return PlacesSearchView(
          title: 'Pickup Location',
          placeholder: 'Enter your pickup location...',
          countryCode: getxMapController.currentCountryCode,
          onPlaceSelect: (detail) {
            bookingController.updatePickUpLat(detail!.lat);
            bookingController.updatePickUpLng(detail.long);

            getxMapController.setPickupLatLng(
                lat: detail.lat,
                lng: detail.long,
                address: detail.label ?? 'No address selected');

            if ((getxMapController.startAddress != "" &&
                getxMapController.destinationAddress != "")) {
              if (getxMapController.markers.isNotEmpty) {
                getxMapController.markers.clear();
              }
              if (getxMapController.polylines.isNotEmpty) {
                getxMapController.polylines.clear();
              }
              if (getxMapController.polylineCoordinates.isNotEmpty) {
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
  }

  InkWell _buildDeliveryLocationField(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectDeliveryLocation(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  "Destination Location",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Color(0xff000000),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GetBuilder<MapController>(
                    builder: (_) => Flexible(
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                              right: 8.0,
                            ),
                            child: Text(
                              getxMapController.getDeliveryLocationAddress(),
                              style: const TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  PersistentBottomSheetController<dynamic> _selectDeliveryLocation(
      BuildContext context) {
    return showBottomSheet(
      context: context,
      elevation: 500,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return PlacesSearchView(
          title: 'Destination Location',
          placeholder: 'Search destination location...',
          countryCode: getxMapController.currentCountryCode,
          onPlaceSelect: (detail) {
            // getxMapController.updateDeliveryAddress(
            //   detail?.label ?? 'No address selected',
            // );
            // getxMapController.updateDestinationLatitudelongitude(
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
              if (getxMapController.polylineCoordinates.isNotEmpty) {
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
  }
}

class _buildPaymentOptionBottomSheet extends StatelessWidget {
  const _buildPaymentOptionBottomSheet({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.4,
      width: screenWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Select Your payment Method",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            // width: screenWidth * 0.9,
            height: screenHeight * 0.3,
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      // height: screenHeight * 0.12,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 10.0, left: 10.0, top: 5, bottom: 5),
                        child: Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Image(
                                        image: AssetImage(
                                            'assets/credit_card.png'),
                                      ),
                                    ),
                                  ]),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "VISA card ending ***12",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Added on 26th Jan, 2022",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
