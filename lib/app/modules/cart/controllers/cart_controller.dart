import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_aos/app/data/models/cart_model.dart';
import 'package:test_aos/app/data/repository.dart';
import 'package:test_aos/app/routes/app_pages.dart';

class CartController extends GetxController {
  final Repository repository;
  CartController(this.repository);
  final box = GetStorage('cart');
  late List<CartModel> cartModels;
  @override
  void onInit() {
    super.onInit();
    cartModels = getCartModels();
  }

  List<CartModel> getCartModels() {
    List<dynamic> cartItems = box.read('cart') ?? [];
    return cartItems.map((item) => CartModel.fromJson(item)).toList();
  }

  double calculateTotalPrice() {
    double total = 0;
    for (var item in cartModels) {
      total += double.parse(item.productModel.productValue) * item.quantity;
    }
    return total;
  }

  double calculateTax() {
    return calculateTotalPrice() * 0.1;
  }

  void addToCart(CartModel cartItem) {
    bool found = false;
    for (var item in cartModels) {
      if (item.productModel.productId == cartItem.productModel.productId) {
        item.quantity += cartItem.quantity;
        found = true;
        break;
      }
    }
    if (!found) {
      cartModels.add(cartItem);
    }
    _saveCartToStorage();
  }

  void incrementQuantity(String productId) {
    for (var item in cartModels) {
      if (item.productModel.productId == productId) {
        item.quantity++;
        break;
      }
    }
    _saveCartToStorage();
  }

  void decrementQuantity(String productId) {
    List<CartModel> itemsToRemove = [];

    for (var item in cartModels) {
      if (item.productModel.productId == productId && item.quantity > 1) {
        item.quantity--;
        _saveCartToStorage();
      } else if (item.productModel.productId == productId) {
        Get.defaultDialog(
          radius: 5,
          title: 'Confirmation',
          middleText: 'Do you want to remove this item from cart?',
          confirm: ElevatedButton(
            onPressed: () {
              Get.back();
              itemsToRemove.add(item);
              cartModels
                  .removeWhere((element) => itemsToRemove.contains(element));
              _saveCartToStorage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.white),
            ),
          ),
          cancel: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              "No",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    }
  }

  Future<void> checkout() async {
    if (cartModels.isNotEmpty) {
      try {
        final response = await repository.insertSales(
          pMethod: 'insert sales',
          pData1: 'MF${Random().nextInt(10000)}',
          pData5: 'JK',
          pDataDetail: cartModels,
        );
        var connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi &&
                response['success'] == true) {
          cartModels.clear();
          _saveCartToStorage();
          Get.rawSnackbar(
            message: 'Checkout success',
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.orange,
            borderRadius: 5,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
          );
          Get.offAllNamed(Routes.APP_NAVIGATION);
        }
      } catch (e) {
        Get.rawSnackbar(
          message: 'No Internet Connection, Please try again later.',
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.black87,
          borderRadius: 5,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
        );
      }
    } else {
      Get.rawSnackbar(
        message: 'Cart is empty',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black87,
        borderRadius: 5,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
      );
    }
  }

  void _saveCartToStorage() {
    box.write('cart', cartModels.map((item) => item.toJson()).toList());
    update();
  }
}
