class ProductModel {
  final int no;
  final String productId;
  final String productName;
  final String productDescription;
  final String productValue;
  final String productType;
  final String productPhoto;

  ProductModel({
    required this.no,
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productValue,
    required this.productType,
    required this.productPhoto,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      no: json['NO'],
      productId: json['productId'],
      productName: json['productName'],
      productDescription: json['productDescription'],
      productValue: json['productValue'],
      productType: json['productType'],
      productPhoto: json['productPhoto'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'NO': no,
      'productId': productId,
      'productName': productName,
      'productDescription': productDescription,
      'productValue': productValue,
      'productType': productType,
      'productPhoto': productPhoto,
    };
  }
}

class ResponseResultProductModel {
  final bool success;
  final String message;
  final List<ProductModel> products;

  ResponseResultProductModel({
    required this.success,
    required this.message,
    required this.products,
  });

  factory ResponseResultProductModel.fromJson(Map<String, dynamic> json) {
    List<ProductModel> products = [];
    if (json['data'] != null && json['data']['Table'] != null) {
      for (var item in json['data']['Table']) {
        products.add(ProductModel.fromJson(item));
      }
    }

    return ResponseResultProductModel(
      success: json['success'],
      message: json['message'],
      products: products,
    );
  }
}

class ResponseResultFromGetProduct {
  final bool success;
  final String message;
  final String data;

  ResponseResultFromGetProduct({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResponseResultFromGetProduct.fromJson(Map<String, dynamic> json) {
    return ResponseResultFromGetProduct(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
  }
}
