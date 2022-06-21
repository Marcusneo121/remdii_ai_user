import 'package:fyp/Models/products.dart';

class CartTesting {
  final Product product;
  final int numOfItems;

  CartTesting({
    required this.product,
    required this.numOfItems,
  });
}

List<CartTesting> demoCarts = [
  CartTesting(product: products[0], numOfItems: 2),
  CartTesting(product: products[1], numOfItems: 3),
  CartTesting(product: products[3], numOfItems: 1),
  CartTesting(product: products[5], numOfItems: 1),
  CartTesting(product: products[2], numOfItems: 1),
];
