import 'package:amar_karigor/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../controllers/location_controller.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LocationController>(
      LocationController(),
    );
     Get.put<HomeController>(
      HomeController(),
    );
  }
}
