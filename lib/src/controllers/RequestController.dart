// ignore_for_file: file_names, non_constant_identifier_names

import 'package:get/get.dart';

class RequestController extends GetxController {
  //Location data
  var pickUpLocationAddress = "Use my current Location";
  var deliveryLocationAddress = "Set your Delivery Location";
  var pickUpLat = 0.0;
  var pickUpLng = 0.0;

  var deliveryLat = 0.0;
  var delivertLng = 0.0;

  var currentLocationAddress = "current Location";
  var currentLocationLatitude = 0.0;
  var currentLocationLongitude = 0.0;

  //Vehicle Size values
  //Default is Small
  var vehicleSize = "Small"; //Small  Large  Extra Large
  var loading = false;
  var OffLoading = false;
  var vehicleSubCategoryId = "";
  var vehicleCategoryId = "";

  var StepProgressPosition = 1;

  //Update methods
  updatePickUpLocationAddress(String address) {
    pickUpLocationAddress = address;
    update();
  }

  updateDeliveryAddress(String address) {
    deliveryLocationAddress = address;
    update();
  }

  updatePickUpLat(double lat) {
    pickUpLat = lat;
    update();
  }

  updatePickUpLng(double lng) {
    pickUpLng = lng;
    update();
  }

  updateDeliveryLat(double lat) {
    deliveryLat = lat;
    update();
  }

  updateDeliveryLng(double lng) {
    delivertLng = lng;
    update();
  }

  updateVehicleSize(String size) {
    vehicleSize = size;
    update();
  }

  updateLoadingExtra(bool selection) {
    loading = selection;
    update();
  }

  updateOffLoadingExtra(bool selection) {
    OffLoading = selection;
    update();
  }

  updateCurrentLocationAddress(String currentAddress) {
    currentLocationAddress = currentAddress;
    update();
  }

  updateCurrentLocation(double? lat, double? lng) {
    currentLocationLatitude = lat!;
    currentLocationLongitude = lng!;
    update();
  }

  UpdateVehicleSubCategoryId(String subCategoryId) {
    vehicleSubCategoryId = subCategoryId;
    update();
  }

  UpdateVehicleCategoryId(String VehicleCategoryId) {
    vehicleCategoryId = VehicleCategoryId;
    update();
  }

  updateStepProgressPosition(int position) {
    StepProgressPosition = position;
    update();
  }

  void addStepProgressPosition() {
    StepProgressPosition + StepProgressPosition + 1;
    update();
  }

  void subtractStepProgressPosition() {
    if (StepProgressPosition == 1) {
      StepProgressPosition = 1;
    } else {
      StepProgressPosition + StepProgressPosition - 1;
    }
    update();
  }
}
