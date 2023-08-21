import 'package:get/get.dart';
import 'package:test_aos/app/constants/strings.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = APIURL;
    httpClient.timeout = const Duration(seconds: 5);
    super.onInit();
  }
}
