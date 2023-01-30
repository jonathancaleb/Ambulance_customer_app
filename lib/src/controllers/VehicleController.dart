import 'package:ambulance_app/src/controllers/BookingController.dart';
import 'package:get/get.dart';

import '../models/VehicleCategory.dart';
import '../models/VehicleSubCategory.dart';
import '../services/vehicleService.dart';

class VehicleController extends GetxController {
  var vehicleCategoriesList = <VehicleCategory>[];
  var vehiclSubCategoriesList = <VehiclSubCategory>[];
  var vehicleSubCategory = null;

  //Inject booking controller
  final bookingController = Get.put(BookingController());
  @override
  void onInit() {
    super.onInit();
    getVehicleCategoryList();
    getSubCategoryList();
  }

  Future<void> getVehicleCategoryList() async {
    vehicleCategoriesList = await getVechicleCategories();
    update();
  }

  Future<void> getSubCategoryList() async {
    String categoryId = bookingController.vehicleCategoryId;
    vehiclSubCategoriesList = await getVehicleSubCategory(categoryId);
    update();
  }

  void updateSelectedVehicleSubCategory(
      VehiclSubCategory newVehicleSubCategory) {
    vehicleSubCategory = newVehicleSubCategory;
    update();
  }
}
