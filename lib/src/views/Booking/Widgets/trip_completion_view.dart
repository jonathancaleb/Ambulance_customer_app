import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../constants/Constants.dart';
import '../../../controllers/BookingController.dart';
import '../../../controllers/DriverController.dart';
import '../../../models/trip_model.dart';

class TripCompletionView extends StatefulWidget {
  const TripCompletionView({Key? key}) : super(key: key);

  @override
  State<TripCompletionView> createState() => _TripCompletionViewState();
}

class _TripCompletionViewState extends State<TripCompletionView> {
  final driverController = Get.put(DriverController());
  final bookingController = Get.put(BookingController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<DriverController>(
      builder: (controller) {
        TripModel? tripModel = controller.tripModel;

        return Column(
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
                            image: DecorationImage(
                              image: NetworkImage(
                                tripModel?.driverPicture ??
                                    Constants.placeHolderUserImage,
                              ),
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
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "${tripModel?.driverName}",
                            style: const TextStyle(
                                color: Color(0xff042B52), fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "${tripModel?.vehicleNumberPlate}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "Rate Your Driver",
                            style: TextStyle(
                              color: Color(0xff042B52),
                              fontSize: 16,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.normal,
                            ),
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
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.normal,
                            ),
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
                                        fontFamily: "Poppins",
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
                                        fontFamily: "Poppins",
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
                                        fontFamily: "Poppins",
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
                                        fontFamily: "Poppins",
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
                                        fontFamily: "Poppins",
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
                            height: size.height * 0.07,
                            width: size.width * 0.7,
                            child: MaterialButton(
                              color: const Color(0xff042B52),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(color: Colors.grey)),
                              onPressed: () {
                                //TODO: shown thank you dialog and go to home screen

                                showDialog(
                                  context: context,
                                  builder: (contextT) => TripRatingCompleteView(
                                    onTap: () {
                                      navController.navigateToPosition(0);

                                      Navigator.of(contextT).pop();
                                    },
                                  ),
                                );
                              },
                              child: const Text(
                                "Submit",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffF1CA2D),
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
            ),
          ],
        );
      },
    );
  }
}

class TripRatingCompleteView extends StatelessWidget {
  @override
  const TripRatingCompleteView({Key? key, required this.onTap})
      : super(key: key);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.65,
          minHeight: MediaQuery.of(context).size.height * 0.45,
        ),
        margin: const EdgeInsets.all(20.0),
        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Image.asset(
              'assets/bukk_logo_1.png',
              height: 22,
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/happy.png',
              height: 120,
            ),
            const SizedBox(height: 10),
            Text(
              'Thank you!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff042B52),
                  ),
            ),
            const SizedBox(height: 15),
            Text(
              'Keep an eye for promotions in your notifications',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 15.0,
                  ),
            ),
            const SizedBox(height: 15),
            Text(
              'Remember that you could win delivery vouchers by inviting your friends and rating the BUKK App',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 15.0,
                  ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 5, left: 10, right: 10),
              child: SizedBox(
                height: size.height * 0.07,
                width: size.width * 0.7,
                child: MaterialButton(
                  color: const Color(0xff042B52),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(color: Colors.grey)),
                  onPressed: () {
                    //TODO: shown thank you dialog and go to home screen
                    onTap();
                  },
                  child: const Text(
                    "Okay",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffF1CA2D),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
