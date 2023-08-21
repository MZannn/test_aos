import 'package:test_aos/app/data/models/product_model.dart';

class CartModel {
  final ProductModel productModel;
  int quantity;

  CartModel({
    required this.productModel,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      productModel: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': productModel.toJson(),
      'quantity': quantity,
    };
  }
}
