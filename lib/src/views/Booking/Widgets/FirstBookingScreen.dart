import 'package:bukk_customer_app/controllers/map_controller.dart';
import 'package:bukk_customer_app/controllers/nav_controller.dart';
import 'package:bukk_customer_app/views/BookingScreens/EditDeliveryLocation.dart';
import 'package:bukk_customer_app/views/places/places_search_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/BookingController.dart';
import '../../../models/VehicleCategory.dart';
import '../../../services/vehicleService.dart';
import 'VehicleInfoDialogView.dart';

class FirstBookingScreen extends StatefulWidget {
  const FirstBookingScreen({Key? key}) : super(key: key);

  @override
  State<FirstBookingScreen> createState() => _FirstBookingScreenState();
}

class _FirstBookingScreenState extends State<FirstBookingScreen> {
  //Inject get controller into home widget
  final bookingController = Get.put(BookingController());
  final navController = Get.put(NavController());

  //Select vehicle Category Id
  String _selectedVehicleCategoryId = "907204f7-04db-424a-aff8-ce393711a68b";

  //Vehicle Card index
  late int selectedehicleCategoryListPosition = -1;
  //Vehicle Size selection
  bool vehicleSizeIsSelected = false;

  //Vehicle Size Selection
  bool _smallSelected = false;
  bool _largeSelected = false;
  bool _ExtraLargeSelected = false;

  //Extras initialization
  bool _loadingSelected = false;
  bool _offLoadingSelected = false;

  void _vehicleSizeSelection(bool selection, int sizeId) {
    if (sizeId == 1) {
      _smallSelected = selection;
      _largeSelected = false;
      _ExtraLargeSelected = false;
    }
    if (sizeId == 2) {
      _smallSelected = false;
      _largeSelected = selection;
      _ExtraLargeSelected = false;
    }
    if (sizeId == 3) {
      _smallSelected = false;
      _largeSelected = false;
      _ExtraLargeSelected = selection;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 30,
          width: screenWidth,
          color: const Color(0xff042B52),
          child: const Center(
            child: Text(
              "How can we move you today?",
              style: TextStyle(color: Color(0xffF1CA2D), fontFamily: "Poppins"),
            ),
          ),
        ),

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
                          title: 'Delivery Location',
                          placeholder: 'Search delivery location...',
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
                              color: Color(0xff042B52),
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
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Center(
                  child: Text(
                    "I would Like this mover",
                    style: TextStyle(
                      color: Color(0xff042B52),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),

            //TODO: Adding the vehicle Category list
            Center(
              child: SizedBox(
                height: screenHeight * 0.17,
                width: screenWidth * 0.9,
                child: FutureBuilder<List<VehicleCategory>>(
                  future: getVechicleCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // List<VehicleCategory>? data = snapshot.data;
                      return Center(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                height: 0.15,
                                width: screenWidth * 0.3,
                                child: InkWell(
                                  onTap: () {
                                    //Handle card on clip
                                    setState(() {
                                      String id =
                                          snapshot.data![index].category_id;
                                      selectedehicleCategoryListPosition =
                                          index;
                                      _selectedVehicleCategoryId =
                                          snapshot.data![index].category_id;
                                      bookingController.UpdateVehicleCategoryId(
                                          snapshot.data![index].category_id);
                                    });
                                  },
                                  child: Card(
                                    elevation:
                                        selectedehicleCategoryListPosition
                                                .isEqual(index)
                                            ? 8
                                            : 1,
                                    color: selectedehicleCategoryListPosition
                                            .isEqual(index)
                                        ? const Color(0xff042B52)
                                        : Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: InkWell(
                                                radius: 20,
                                                onTap: () {
                                                  //Open vehicle information dialog
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        VehicleInfoDialogView(
                                                      category:
                                                          snapshot.data![index],
                                                    ),
                                                  );
                                                  // showDialog(
                                                  //     context: context,
                                                  //     builder: (BuildContext
                                                  //         context) {
                                                  //       return AlertDialog(
                                                  //         content:
                                                  //             SingleChildScrollView(
                                                  //           child: Column(
                                                  //             mainAxisSize:
                                                  //                 MainAxisSize
                                                  //                     .min,
                                                  //             crossAxisAlignment:
                                                  //                 CrossAxisAlignment
                                                  //                     .center,
                                                  //             children: [
                                                  //               SizedBox(
                                                  //                 height:
                                                  //                     screenHeight *
                                                  //                         0.15,
                                                  //                 width:
                                                  //                     screenWidth *
                                                  //                         0.3,
                                                  //                 child:
                                                  //                     CachedNetworkImage(
                                                  //                   imageUrl: snapshot
                                                  //                       .data![
                                                  //                           index]
                                                  //                       .image,
                                                  //                   placeholder:
                                                  //                       (context,
                                                  //                               url) =>
                                                  //                           const CircularProgressIndicator(),
                                                  //                   errorWidget: (context,
                                                  //                           url,
                                                  //                           error) =>
                                                  //                       const Icon(
                                                  //                           Icons.error),
                                                  //                 ),
                                                  //               ),
                                                  //               Text(
                                                  //                 snapshot
                                                  //                     .data![
                                                  //                         index]
                                                  //                     .name,
                                                  //                 textAlign:
                                                  //                     TextAlign
                                                  //                         .start,
                                                  //                 style: const TextStyle(
                                                  //                     color: Colors
                                                  //                         .black,
                                                  //                     fontFamily:
                                                  //                         "Poppins",
                                                  //                     fontSize:
                                                  //                         18,
                                                  //                     fontWeight:
                                                  //                         FontWeight
                                                  //                             .bold),
                                                  //               ),
                                                  //               Text(
                                                  //                 snapshot
                                                  //                     .data![
                                                  //                         index]
                                                  //                     .information,
                                                  //                 textAlign:
                                                  //                     TextAlign
                                                  //                         .left,
                                                  //                 style:
                                                  //                     const TextStyle(
                                                  //                   color: Colors
                                                  //                       .grey,
                                                  //                   fontFamily:
                                                  //                       "Poppins",
                                                  //                   fontSize:
                                                  //                       16,
                                                  //                 ),
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //       );
                                                  //     });
                                                },
                                                child: const Card(
                                                  color: Color(0xfff1ca2d),
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color:
                                                            Color(0xfff1ca2d),
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20),
                                                      bottomLeft:
                                                          Radius.circular(20),
                                                      bottomRight:
                                                          Radius.circular(20),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "i",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color:
                                                            Color(0xff042B52),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.20 * 0.3,
                                          width: screenWidth * 0.25 * 0.8,
                                          child: Image.network(
                                              snapshot.data![index].image),
                                        ),
                                        Text(
                                          snapshot.data![index].name,
                                          style: TextStyle(
                                            color:
                                                selectedehicleCategoryListPosition
                                                        .isEqual(index)
                                                    ? Colors.white
                                                    : const Color(0xff042B52),
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
                      // return Center(child: Text("${snapshot.error}"));
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Color(0xff042B52),
                      ));
                    }
                  },
                ),
              ),
            ),

            //TODO: add a row for the user to select the vehicle size
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Center(
                  child: Text(
                    "Select Vehicle Size",
                    style: TextStyle(
                      color: Color(0xff042B52),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),

            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: FilterChip(
                      label: Text(
                        "Small",
                        style: TextStyle(
                          color: _smallSelected
                              ? const Color(0xffffffff)
                              : const Color(0xff042b52),
                          fontSize: 12,
                        ),
                      ),
                      backgroundColor: _smallSelected
                          ? const Color(0xffffffff)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Color(0xff042B52), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      selectedColor: const Color(0xff042B52),
                      selected: _smallSelected,
                      checkmarkColor: _smallSelected
                          ? const Color(0xffffffff)
                          : const Color(0xff042B52),
                      onSelected: (bool value) {
                        setState(() {
                          _vehicleSizeSelection(value, 1);
                          if (value) {
                            bookingController.updateVehicleSize("small");
                            vehicleSizeIsSelected = true;
                          } else {
                            bookingController.updateVehicleSize("");
                            vehicleSizeIsSelected = false;
                          }
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: FilterChip(
                      label: Text(
                        "Large",
                        style: TextStyle(
                          color: _largeSelected
                              ? const Color(0xffffffff)
                              : const Color(0xff042B52),
                          fontSize: 12,
                        ),
                      ),
                      backgroundColor: _largeSelected
                          ? const Color(0xffffffff)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Color(0xff042B52), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      selectedColor: const Color(0xff042B52),
                      selected: _largeSelected,
                      checkmarkColor: _largeSelected
                          ? const Color(0xffffffff)
                          : const Color(0xff042B52),
                      onSelected: (bool value) {
                        setState(() {
                          _vehicleSizeSelection(value, 2);
                          if (value) {
                            bookingController.updateVehicleSize("Large");
                            vehicleSizeIsSelected = true;
                          } else {
                            bookingController.updateVehicleSize("");
                            vehicleSizeIsSelected = false;
                          }
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: FilterChip(
                      label: Text(
                        "Extra Large",
                        style: TextStyle(
                          color: _ExtraLargeSelected
                              ? const Color(0xffffffff)
                              : const Color(0xff042B52),
                          fontSize: 12,
                        ),
                      ),
                      backgroundColor: _ExtraLargeSelected
                          ? const Color(0xffffffff)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Color(0xff042B52), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      selectedColor: const Color(0xff042B52),
                      selected: _ExtraLargeSelected,
                      checkmarkColor: _largeSelected
                          ? const Color(0xff042B52)
                          : const Color(0xffffffff),
                      onSelected: (bool value) {
                        setState(() {
                          _vehicleSizeSelection(value, 3);
                          if (value) {
                            bookingController.updateVehicleSize("Extra Large");
                            vehicleSizeIsSelected = true;
                          } else {
                            bookingController.updateVehicleSize("");
                            vehicleSizeIsSelected = false;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Center(
                  child: Text(
                    "I also need help with",
                    style: TextStyle(
                        color: Color(0xff042B52),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )),

            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 5, right: 5),
                    child: SizedBox(
                      height: screenHeight * 0.05,
                      child: FilterChip(
                        label: Text(
                          "Loading",
                          style: TextStyle(
                            color: _loadingSelected
                                ? const Color(0xffffffff)
                                : const Color(0xff042B52),
                            fontSize: 12,
                          ),
                        ),
                        backgroundColor: _loadingSelected
                            ? const Color(0xffffffff)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color(0xff042B52), width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        selectedColor: const Color(0xff042B52),
                        selected: _loadingSelected,
                        checkmarkColor: _loadingSelected
                            ? const Color(0xffffffff)
                            : const Color(0xff042B52),
                        onSelected: (bool value) {
                          setState(() {
                            _loadingSelected = value;
                            if (value) {
                              bookingController.updateLoadingExtra(value);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 5, right: 5),
                    child: SizedBox(
                      height: screenHeight * 0.05,
                      //width: screenWidth * 0.3,
                      child: FilterChip(
                        label: Text(
                          "Offloading",
                          style: TextStyle(
                            color: _offLoadingSelected
                                ? const Color(0xffffffff)
                                : const Color(0xff042B52),
                            fontSize: 12,
                          ),
                        ),
                        backgroundColor: _offLoadingSelected
                            ? const Color(0xffffffff)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color(0xff042B52), width: 0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        selectedColor: const Color(0xff042B52),
                        selected: _offLoadingSelected,
                        checkmarkColor: _offLoadingSelected
                            ? const Color(0xffffffff)
                            : const Color(0xff042B52),
                        onSelected: (bool value) {
                          setState(() {
                            _offLoadingSelected = value;
                            if (value) {
                              bookingController.updateOffLoadingExtra(value);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                height: screenHeight * 0.07,
                width: screenWidth * 0.7,
                child: MaterialButton(
                  color: const Color(0xff042B52),
                  disabledColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: (!selectedehicleCategoryListPosition.isEqual(-1) &&
                          vehicleSizeIsSelected == true)
                      ? () {
                          navController.addToBookingPosition();
                        }
                      : null,
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
