import 'package:ambulance_app/src/services/bukk_exporter.dart';

class NavController extends GetxController {
  var stepProgress = 1.obs;
  int bottomNavigationPosition = 2;

  //Panel height Factor
  double panelMaxHeightFactor = 0.72;
  double panelMinHeightFactor = 0.4;

  //Slide Up panel maximum height

  //Main Navigation variable
  var bookingIndexedStackPosition = 1.obs;

  //Booking screens position
  int bookingPosition = 0;

  addStepProgress() {
    stepProgress++;
    update();
  }

  subtractStepProgress() {
    if (stepProgress < 1) {
      stepProgress = 1 as RxInt;
    } else {
      stepProgress--;
    }

    update();
  }

  updateBottomNavigationPosition(int index) {
    bottomNavigationPosition = index;
    update();
  }

//Bottom Navigation Bar logic

  void updateBottomNavigationPositino(int index) {
    bottomNavigationPosition = index;
    update();
  }

  // Navigate to index stack
  void navigateToPosition(int index) {
    bookingPosition = index;
    stepProgress = index.obs;
    setPanelHeightFactor();
    update();
  }

  //Add to booking position
  void addToBookingPosition() {
    bookingPosition = bookingPosition + 1;
    addStepProgress();
    setPanelHeightFactor();
    update();
  }

  void subtractFromBookingPosition() {
    if (bookingPosition < 0) {
      bookingPosition = 0;
    } else {
      bookingPosition--;
      subtractStepProgress();
    }
    setPanelHeightFactor();
    update();
  }

  void setPanelHeightFactor() {
    if (bookingPosition == 0) {
      panelMaxHeightFactor = 0.72;
      panelMinHeightFactor = 0.4;
    }
    if (bookingPosition == 1) {
      panelMaxHeightFactor = 0.9;
      panelMinHeightFactor = 0.4;
    }
    if (bookingPosition == 2) {
      panelMaxHeightFactor = 0.4;
      panelMinHeightFactor = 0.4;
    }
  }

  void getPanelHeightFactor() {
    if (bookingPosition == 0) {
      panelMaxHeightFactor = 0.8;
      panelMinHeightFactor = 0.4;
    }
    if (bookingPosition == 1) {
      panelMaxHeightFactor = 0.87;
      panelMinHeightFactor = 0.4;
    }

    if (bookingPosition == 2 || bookingPosition == 3) {
      panelMaxHeightFactor = 0.5;
      panelMinHeightFactor = 0.5;
    }

    if (bookingPosition == 4) {
      panelMaxHeightFactor = 0.65;
      panelMinHeightFactor = 0.4;
    }
    update();
  }

  double getPanelMaxHeightFactor(double screenHeight) {
    double maxHeight = 0.0;
    if (bookingPosition == 0) {
      maxHeight = screenHeight * 0.72;
    }
    if (bookingPosition == 1) {
      maxHeight = screenHeight * 0.9;
    }

    if (bookingPosition == 2 || bookingPosition == 3) {
      maxHeight = screenHeight * 0.5;
    }

    if (bookingPosition == 4) {
      maxHeight = screenHeight * 0.65;
    }
    return maxHeight;
  }

  // double getPanelMinHeight(double screenHeight) {
  //   double minHeight = 0.0;
  //   if (bookingPosition == 0) {
  //     minHeight = screenHeight * 0.72;
  //   }
  //   if (bookingPosition == 1) {
  //     minHeight = screenHeight * 0.9;
  //   }

  //   if (bookingPosition == 2 || bookingPosition == 3) {
  //     minHeight = screenHeight * 0.5;
  //   }

  //   if (bookingPosition == 4) {
  //     minHeight = screenHeight * 0.65;
  //   }

  //   return minHeight;
  // }
}
