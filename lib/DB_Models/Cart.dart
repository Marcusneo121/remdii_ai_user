import 'package:fyp/DB_Models/Products.dart';

class Cart {
  final Product product;
  final int qty;

  Cart({required this.product, required this.qty});

  // factory Cart.fromJson(Map<String, dynamic> json) {
  //   return Cart(
  //       product: Product.fromJson(json['product']),
  //       qty: int.parse(json['qty']));
  // }
}
