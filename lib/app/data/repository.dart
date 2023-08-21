import 'package:test_aos/app/constants/strings.dart';
import 'package:test_aos/app/data/models/product_model.dart';
import 'package:test_aos/app/data/services/network_services.dart';

import 'models/cart_model.dart';

class Repository {
  final NetworkServices networkServices;

  Repository({required this.networkServices});

  Future<ResponseResultFromGetProduct> getProductData(
      {required String pEmail,
      required String pWhere6,
      required String pWhere7,
      required String pMethod}) async {
    final body = {
      "KEY": KEY,
      "pMethod": pMethod,
      "pEmail": pEmail,
      "pWhere6": pWhere6,
      "pWhere7": pWhere7,
    };

    try {
      final apiResponse = await networkServices.getProductData(body);
      return apiResponse;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> insertSales({
    required String pMethod,
    required String pData1,
    required String pData5,
    required List<CartModel> pDataDetail,
  }) async {
    try {
      final apiResponse = await networkServices.insertSales({
        "KEY": KEY,
        "pMethod": pMethod,
        "pData1": pData1,
        "pData5": pData5,
        "pDataDetail": pDataDetail.map((e) => e.toJson()).toList(),
      });
      return apiResponse;
    } catch (e) {
      throw Exception(e);
    }
  }
}
