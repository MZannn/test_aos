import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:test_aos/app/data/models/product_model.dart';
import 'package:test_aos/app/data/services/base_provider.dart';

class NetworkServices {
  final BaseProvider baseProvider;
  NetworkServices({required this.baseProvider});

  Future<ResponseResultFromGetProduct> getProductData(
      Map<String, dynamic> body) async {
    try {
      final response =
          await baseProvider.post('/GetMasterData', body, headers: {
        'Content-Type': 'application/json',
      });
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi &&
              response.statusCode == 200) {
        ResponseResultFromGetProduct responseData =
            ResponseResultFromGetProduct.fromJson(response.body);
        return responseData;
      } else {
        throw Exception('No Internet Connection');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> insertSales(Map<String, dynamic> body) async {
    try {
      final response = await baseProvider.post('/UpdateData', body, headers: {
        'Content-Type': 'application/json',
      });
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi &&
              response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('No Internet Connection');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
