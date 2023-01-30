import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../constants/Constants.dart';
import '../../controllers/BookingController.dart';
import '../../controllers/DriverController.dart';
import '../../models/trip_model.dart';

class DriverMatchScreen extends StatefulWidget {
  const DriverMatchScreen({Key? key}) : super(key: key);

  @override
  State<DriverMatchScreen> createState() => _DriverMatchScreenState();
}

class _DriverMatchScreenState extends State<DriverMatchScreen> {
  final driverController = Get.put(DriverController());
  final bookingController = Get.put(BookingController());

  @override
  void initState() {
    bookingController.addStepProgressPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GetBuilder<DriverController>(
      builder: (controller) {
        TripModel? tripModel = controller.tripModel;

        return Column(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () =>
                        launchUrlString('tel:${tripModel?.driverPhoneNumber}'),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.phone,
                        color: Color(0xff042B52),
                      ),
                    ),
                    shape: const CircleBorder(
                      side: BorderSide(
                        width: 3,
                        color: Color(0xff042B52),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: DecorationImage(
                            image: NetworkImage(
                              tripModel?.driverPicture ??
                                  Constants.placeHolderUserImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 35.0,
                          height: 35.0,
                          decoration: const BoxDecoration(
                            color: Color(0xff042B52),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              '4.9',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  MaterialButton(
                    onPressed: () => launchUrlString(
                      'sms:${tripModel?.driverPhoneNumber}',
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.mail,
                        color: Color(0xff042B52),
                      ),
                    ),
                    shape: const CircleBorder(
                      side: BorderSide(
                        width: 3,
                        color: Color(0xff042B52),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Text(
                    "${tripModel?.driverName}",
                    style:
                        const TextStyle(color: Color(0xff042B52), fontSize: 16),
                  ),
                  Text(
                    "${tripModel?.vehicleNumberPlate}",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                //TODO: Send a trip cancel message via the web socket connection
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 150,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                  'Are you sure you want to Cancel this trip?'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    height: screenHeight * 0.07,
                                    width: screenWidth * 0.3,
                                    child: MaterialButton(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
                                            "No",
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
                                    height: screenHeight * 0.07,
                                    width: screenWidth * 0.3,
                                    child: MaterialButton(
                                      color: const Color(0xff042B52),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          side: const BorderSide(
                                              color: Color(0xff042B52))),
                                      onPressed: () {
                                        //TODO: Add the close modal bottom sheet
                                        //
                                        driverController.cancelTrip();
                                      },
                                      child: const Center(
                                        child: Center(
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                color: Colors.white),
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
                      ),
                    );
                  },
                );
              },
              child: const Text(
                "Cancel Ride...",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffF1CA2D),
                  fontFamily: "Poppins",
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
