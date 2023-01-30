import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../controllers/BookingController.dart';
import '../../controllers/VehicleController.dart';
import '../../controllers/map_controller.dart';
import '../../controllers/nav_controller.dart';
import '../../models/VehicleSubCategory.dart';
import '../../services/BookingService.dart';
import '../../services/vehicleService.dart';
import '../places/places_search_view.dart';
import 'Widgets/VehicleInfoDialogView.dart';
import 'Widgets/booking_loading_dialog.dart';
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
  final bookingController = Get.put(BookingController());
  final navController = Get.put(NavController());
  final vehiclController = Get.put(VehicleController());
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
                color: const Color(0xff042B52),
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
                  "And I Would love these capacities",
                  style: TextStyle(
                    color: Color(0xff042B52),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
            ),

            //Vehicle sub category list
            GetBuilder<BookingController>(
              builder: (bookingController) => SizedBox(
                width: screenWidth,
                // height: screenHeight * 0.3,
                child: FutureBuilder<List<VehiclSubCategory>>(
                  future: getVehicleSubCategory(
                      bookingController.vehicleCategoryId.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: getVehicleCapacities(snapshot.data!, size),
                      );

                      return Scrollbar(
                        trackVisibility: true,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.0, left: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      vehicleCardIndex = index;
                                      //add selected sub category object ton vehicle controller
                                      vehiclController
                                          .updateSelectedVehicleSubCategory(
                                              snapshot.data![index]);
                                    });
                                  },
                                  child: Card(
                                    elevation: 8,
                                    color: vehicleCardIndex.isEqual(index)
                                        ? const Color(0xff042B52)
                                        : Colors.white,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                  height: screenHeight * 0.09,
                                                  width: screenWidth * 0.2,
                                                  child: CachedNetworkImage(
                                                    imageUrl: snapshot
                                                        .data![index].image,
                                                    placeholder: (context,
                                                            url) =>
                                                        const CircularProgressIndicator(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  )),
                                              Text(
                                                snapshot.data![index].name,
                                                style: TextStyle(
                                                    color: vehicleCardIndex
                                                            .isEqual(index)
                                                        ? Colors.white
                                                        : const Color(
                                                            0xff042B52),
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Poppins"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(flex: 2),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "R925",
                                                style: TextStyle(
                                                    color: vehicleCardIndex
                                                            .isEqual(index)
                                                        ? Colors.white
                                                        : Colors.grey[800],
                                                    fontSize: 14,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontFamily: "Poppins"),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  "R" +
                                                      snapshot.data![index].fee
                                                          .toString(),
                                                  style: TextStyle(
                                                    color: vehicleCardIndex
                                                            .isEqual(index)
                                                        ? const Color(
                                                            0xfff1ca2d)
                                                        : const Color(
                                                            0xff042B52),
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  "Arrival Time: " +
                                                      snapshot.data![index]
                                                          .arrival_time,
                                                  style: TextStyle(
                                                    color: vehicleCardIndex
                                                            .isEqual(index)
                                                        ? Colors.white
                                                        : Colors.grey[800],
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
                            }),
                      );
                    } else {
                      //return Text("${snapshot.error}");
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Color(0xff042B52),
                      ));
                      //TODO: add shimmer container

                    }
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Costs and Times are close estimates",
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
                  "And Pay with",
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
                            color: Color(0xfff1ca2d),
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
                          color: const Color(0xff042B52),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: const BorderSide(color: Color(0xff042B52))),
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
                                  color: Color(0xfff1ca2d),
                                  size: 45,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    DateTimePicker(),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 5, left: 5, right: 10),
                      child: SizedBox(
                        height: screenHeight * 0.065,
                        width: screenWidth * 0.45,
                        child: MaterialButton(
                          color: const Color(0xff042B52),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(
                                color: Color(0xff042B52),
                              )),
                          onPressed: () {
                            //Check if the user has selected the a vehicle sub-category
                            if (selectedCategory == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    "Please Select a vehicle sub-category to proceed"),
                                duration: Duration(milliseconds: 1000),
                              ));
                            } else {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return const BookingDialog();
                                  });
                              // Fire Send booking request network call.
                              submitBookingRequest().then((value) {
                                if (value) {
                                  setState(() {
                                    Navigator.pop(context);
                                    navController.addToBookingPosition();
                                  });
                                } else {
                                  //Dismiss keyboard
                                  FocusScope.of(context).unfocus();
                                  Navigator.pop(context);
                                  //show failed booking dialog
                                  showMatchingFailedDialog(
                                      context, screenHeight, screenWidth);
                                }
                              });
                            }
                          },
                          child: const Text(
                            "Let's Move!",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xfff1ca2d),
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
                              color: Color(0xff042B52),
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
                                  color: Color(0xff042B52),
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
                          color: const Color(0xff042B52),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: const BorderSide(color: Color(0xff042B52))),
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

  VehiclSubCategory? selectedCategory;
  List<Widget> getVehicleCapacities(List<VehiclSubCategory> list, Size size) {
    return list.map((category) {
      return Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: selectedCategory == category
                ? const Color(0xff042B52)
                : Colors.white,
          ),
          child: Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(5.0),
            color: selectedCategory == category
                ? const Color(0xff042B52)
                : Colors.white,
            child: InkWell(
              highlightColor: Colors.transparent,
              borderRadius: BorderRadius.circular(5.0),
              onTap: () {
                setState(() {
                  selectedCategory = category;
                  // vehicleCardIndex = index;
                  //add selected sub category object ton vehicle controller
                  vehiclController.updateSelectedVehicleSubCategory(category);
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfo(category),
                            SizedBox(
                              height: 55,
                              // width: size.width * 0.2,
                              child: CachedNetworkImage(
                                imageUrl: category.image,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xfff1ca2d),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          category.name,
                          style: TextStyle(
                            color: selectedCategory == category
                                ? Colors.white
                                : const Color(0xff042B52),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "R925",
                          style: TextStyle(
                            color: selectedCategory == category
                                ? Colors.white
                                : Colors.grey[800],
                            fontSize: 13,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "R" + category.fee.toString(),
                            style: TextStyle(
                              color: selectedCategory == category
                                  ? const Color(0xfff1ca2d)
                                  : const Color(0xff042B52),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Arrival: " + category.arrival_time,
                            style: TextStyle(
                              color: selectedCategory == category
                                  ? Colors.white
                                  : Colors.grey[800],
                              fontSize: 13.0,
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
        ),
      );
    }).toList();
  }

  Widget _buildInfo(VehiclSubCategory category) {
    return SizedBox(
      height: 30,
      width: 30,
      child: InkWell(
        radius: 20,
        onTap: () {
          //Open vehicle information dialog
          showDialog(
            context: context,
            builder: (context) => VehicleInfoDialogView(
              category: category,
            ),
          );
        },
        child: const Card(
          color: Color(0xfff1ca2d),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xfff1ca2d), width: 2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3),
              topRight: Radius.circular(3),
              bottomLeft: Radius.circular(3),
              bottomRight: Radius.circular(3),
            ),
          ),
          child: Center(
            child: Text(
              "i",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                // fontStyle: FontStyle.italic,
                color: Color(0xff042B52),
              ),
            ),
          ),
        ),
      ),
    );
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
                    color: Color(0xffF1CA2D),
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
                  "Delivery Location",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Color(0xffF1CA2D),
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
          title: 'Delivery Location',
          placeholder: 'Search delivery location...',
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
              isAlwaysShown: true,
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
