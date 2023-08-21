import 'package:get/get.dart';
import 'package:test_aos/app/data/repository.dart';

import 'package:test_aos/app/data/services/base_provider.dart';
import 'package:test_aos/app/data/services/network_services.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BaseProvider(), permanent: true);
    Get.put(NetworkServices(baseProvider: Get.find()), permanent: true);
    Get.put(Repository(networkServices: Get.find()), permanent: true);
  }
}
