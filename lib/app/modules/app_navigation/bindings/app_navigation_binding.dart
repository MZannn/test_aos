import 'package:get/get.dart';
import 'package:test_aos/app/modules/home/controllers/home_controller.dart';

import '../controllers/app_navigation_controller.dart';

class AppNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppNavigationController>(
      () => AppNavigationController(),
    );
    Get.lazyPut(() => HomeController(Get.find()));
  }
}
