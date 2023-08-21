import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/models/cart_model.dart';

class DetailProductController extends GetxController {
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

  void _saveCartToStorage() {
    box.write('cart', cartModels.map((item) => item.toJson()).toList());
    update();
  }
}
