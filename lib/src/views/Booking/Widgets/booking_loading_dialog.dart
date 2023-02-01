import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import '../../../controllers/VehicleController.dart';
import '../../../controllers/map_controller.dart';
import '../../widgets/timer_widget.dart';

class BookingDialog extends StatefulWidget {
  const BookingDialog({Key? key}) : super(key: key);

  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  final vehicleController = Get.put(VehicleController());
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              height: screenHeight * 0.85,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 22.0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'Ready to move?',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: const Color(0xff042B52),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  const TimerWidget(durationInSeconds: 60),

                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        "This is coming your way",
                        style: TextStyle(
                          color: Color(0xff042B52),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  //location card
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff042B52),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
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
                                      image: Svg(
                                          "assets/location_dotted_line.svg"),
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
                                width: screenWidth * 0.7,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Pick up location Field
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: const [
                                              Text(
                                                "Pick Up Location",
                                                style: TextStyle(
                                                    fontFamily: "Regular",
                                                    color: Color(0xffF1CA2D),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              GetBuilder<MapController>(
                                                  builder: (_) => Flexible(
                                                        fit: FlexFit.tight,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            getxMapController
                                                                .currentAddress,
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  "Regular",
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ),
                                                      )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    //Delivery Location Field
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: const [
                                              Text(
                                                "Delivery Location",
                                                style: TextStyle(
                                                    fontFamily: "Regular",
                                                    color: Color(0xffF1CA2D),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              GetBuilder<MapController>(
                                                  builder: (_) => Flexible(
                                                        fit: FlexFit.tight,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            getxMapController
                                                                .getDeliveryLocationAddress(),
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  "Regular",
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ),
                                                      )),
                                            ],
                                          ),
                                        ],
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
                  ),

                  //Vehicle Subcaetgory card
                  SizedBox(
                    height: screenHeight * 0.15,
                    width: screenWidth * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff042B52),
                        ),
                        child: GetBuilder<VehicleController>(
                          builder: (vehicleControler) => Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 2, bottom: 2),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height: screenHeight * 0.08,
                                          width: screenWidth * 0.2,
                                          child: CachedNetworkImage(
                                            imageUrl: vehicleController
                                                .vehicleSubCategory.image,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          )),
                                      Text(
                                        vehicleController
                                            .vehicleSubCategory.name,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Regular"),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(flex: 2),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      "R925",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontFamily: "Regular"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        "R${vehicleController.vehicleSubCategory.fee}",
                                        style: const TextStyle(
                                          color: Color(0xfff1ca2d),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Arrival: " +
                                            vehicleController.vehicleSubCategory
                                                .arrival_time,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //Selected Payment method
                  SizedBox(
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff042B52),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: screenHeight * 0.1 * 0.9,
                                width: 60,
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Image(
                                    image: AssetImage('assets/credit_card.png'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.1 * 0.9,
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "*** **** **** 4582",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
