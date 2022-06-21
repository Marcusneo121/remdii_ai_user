import 'Products.dart';

class OrderDetails {
  final String orderID;
  final Product products;
  final int qty;
  final double totalPrice;

  OrderDetails({
    required this.products,
    required this.qty,
    required this.totalPrice,
    required this.orderID,
  });

}
