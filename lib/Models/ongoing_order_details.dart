import 'package:fyp/Models/products.dart';

class OrderDetails {
  final Product product;
  final int numOfItems;

  OrderDetails({
    required this.product,
    required this.numOfItems,
  });
}

List<OrderDetails> demoOrderDetails = [
  OrderDetails(product: products[0], numOfItems: 2),
  OrderDetails(product: products[1], numOfItems: 3),
  OrderDetails(product: products[2], numOfItems: 1),
];