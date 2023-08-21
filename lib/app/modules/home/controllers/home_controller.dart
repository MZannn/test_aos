import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_aos/app/constants/list.dart';
import 'package:test_aos/app/data/models/product_model.dart';
import 'package:test_aos/app/data/repository.dart';

class HomeController extends GetxController
    with StateMixin<ResponseResultProductModel> {
  final Repository repository;
  HomeController(this.repository);

  Timer? _autoSlideTimer;
  final box = GetStorage('cart');
  RxInt carrouselIndex = 0.obs;
  PageController carousselController = PageController();

  @override
  void onInit() {
    super.onInit();
    startAutoSlide();
    fetchProducts();
  }

  @override
  void dispose() {
    super.dispose();
    carousselController.dispose();
  }

  @override
  void onClose() {
    super.onClose();
    _stopAutoSlide();
  }

  void toggleFavoriteStatus(String productId) {
    final favorites = box.read('favorites') ?? <String>[];

    if (favorites.contains(productId)) {
      favorites.remove(productId);
    } else {
      favorites.add(productId);
    }

    box.write('favorites', favorites);
    update();
  }

  bool isProductFavorite(String productId) {
    final favorites = box.read('favorites') ?? <String>[];
    return favorites.contains(productId);
  }

  Future<void> fetchProducts() async {
    change(null, status: RxStatus.loading());
    try {
      List<ProductModel> products = [];
      final apiResponse = await repository.getProductData(
        pEmail: 'JK',
        pWhere6: '1',
        pWhere7: '4',
        pMethod: 'Get Product',
      );
      final decodedResponseData = ResponseResultFromGetProduct.fromJson({
        'data': apiResponse.data,
        'message': apiResponse.message,
        'success': apiResponse.success,
      });
      final jsonData = json.decode(decodedResponseData.data);
      final productsData = jsonData['Table'] as List<dynamic>;

      for (var productJson in productsData) {
        products.add(ProductModel.fromJson(productJson));
      }
      change(
          ResponseResultProductModel(
              success: decodedResponseData.success,
              message: decodedResponseData.message,
              products: products),
          status: RxStatus.success());
    } catch (e) {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.mobile ||
          connectivityResult != ConnectivityResult.wifi) {
        change(null, status: RxStatus.error('No Internet Connection'));
      } else {
        change(null, status: RxStatus.error('Failed to Load Data'));
      }
    }
  }

  void startAutoSlide() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (carrouselIndex < imageUrls.length - 1) {
        carrouselIndex.value++;
      } else {
        carrouselIndex.value = 0;
      }
      if (carousselController.hasClients) {
        carousselController.animateToPage(
          carrouselIndex.value,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      } else {
        carousselController = PageController(initialPage: carrouselIndex.value);
      }
      startAutoSlide();
    });
  }

  void _stopAutoSlide() {
    _autoSlideTimer?.cancel();
    carousselController.dispose();
  }
}
