import 'dart:async';

import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../controllers/RequestController.dart';
import '../../controllers/nav_controller.dart';
import '../widgets/maps_widget.dart';
import 'OngoingTripScreen.dart';
import 'Request_screen_2.dart';
import '../../controllers/map_controller.dart';
import '../../services/exporter.dart';
import 'Widgets/Request_screen_1.dart';
import 'Widgets/StepperProgress.dart';

// import 'driver_matched_screen.dart';

class AmbulanceScreen extends StatefulWidget {
  const AmbulanceScreen({Key? key}) : super(key: key);

  @override
  State<AmbulanceScreen> createState() => _AmbulanceScreenState();
}

class _AmbulanceScreenState extends State<AmbulanceScreen>
    with SingleTickerProviderStateMixin {
  //Inject get controller into home widget
  final bookingController = Get.put(RequestController());
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
                        // const DriverMatchScreen(),

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
