import 'dart:async';

import 'package:bukk_customer_app/controllers/BookingController.dart';
import 'package:bukk_customer_app/views/Booking/Widgets/FirstBookingScreen.dart';
import 'package:bukk_customer_app/views/widgets/maps_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'OngoingTripScreen.dart';
import 'PlaceBookingScreen.dart';
import '../../controllers/map_controller.dart';
import '../../services/bukk_exporter.dart';
import 'Widgets/StepperProgress.dart';
import 'package:bukk_customer_app/controllers/nav_controller.dart';

import 'Widgets/trip_completion_view.dart';
import 'driver_matched_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  //Inject get controller into home widget
  final bookingController = Get.put(BookingController());
  final getxMapController = Get.put(MapController());
  final navController = Get.put(NavController());

  late double panelMaxHeight;
  late double panelMinHeight;

  PanelController controller = PanelController();

  @override
  void initState() {
    getxMapController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    _getPanelMinHeightFactor(screenHeight);
    _getPanelMaxHeightFactor(screenHeight);

    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: GetBuilder<NavController>(
          builder: (navController) => SlidingUpPanel(
            controller: controller,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            minHeight: screenHeight * 0.4,
            maxHeight: screenHeight * navController.panelMaxHeightFactor,
            body: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Positioned.fill(
                    child: GetBuilder<MapController>(
                  init: MapController(),
                  builder: (GetxController controller) => MapsWidget(
                    initialLocation: getxMapController.initialLocation,
                    markers: getxMapController.markers,
                    polylines: getxMapController.polylines,
                    onMapCreated: (controller) {
                      getxMapController.completer.complete(controller);
                      getxMapController.updateMapController(controller);
                      getxMapController.getCurrentLocation();
                    },
                  ),
                )),
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: StepProgress(),
                ),
              ],
            ),
            panel: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WillPopScope(
                  onWillPop: () async {
                    setState(() {
                      navController.subtractFromBookingPosition();
                      navController.subtractStepProgress();
                    });
                    return false;
                  },
                  child: Expanded(
                    child: IndexedStack(
                      index: navController.bookingPosition < 0
                          ? 0
                          : navController.bookingPosition,
                      children: [
                        // const TripCompletionView(),
                        const FirstBookingScreen(),
                        PlaceBookingScreen(
                          controller: controller,
                        ),
                        const DriverMatchScreen(),
                        const TripCompletionView(),
                        //OngoingTripScreen()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _getPanelMaxHeightFactor(double screenHeight) {
    //double panelMaxHeight = 0.7;
    setState(() {
      if (navController.bookingPosition == 0) {
        panelMaxHeight = screenHeight * 0.72;
      }
      if (navController.bookingPosition == 1) {
        panelMaxHeight = screenHeight * 0.9;
      }

      if (navController.bookingPosition == 2 ||
          navController.bookingPosition == 3) {
        panelMaxHeight = screenHeight * 0.5;
      }

      if (navController.bookingPosition == 4) {
        panelMaxHeight = screenHeight * 0.65;
      }
    });

    //return maxHeight;
  }

  void _getPanelMinHeightFactor(double screenHeight) {
    //double minHeight = screenHeight * 0.4;
    if (navController.bookingPosition == 0) {
      panelMinHeight = screenHeight * 0.4;
    }
    if (navController.bookingPosition == 1) {
      panelMinHeight = screenHeight * 0.4;
    }

    if (navController.bookingPosition == 2 ||
        navController.bookingPosition == 3) {
      panelMinHeight = screenHeight * 0.5;
    }

    if (navController.bookingPosition == 4) {
      panelMinHeight = screenHeight * 0.6;
    }

    //return minHeight;
  }
}