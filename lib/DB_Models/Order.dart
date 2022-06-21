import 'package:fyp/DB_Models/OrderDetails.dart';

class Order {
  final String orderID;
  final String orderDate;
  final String orderTime;
  final String shippedDate;
  final String shippedTime;
  final List<OrderDetails> orderDetails;
  final double amount, shippingFee;
  final String status;
  final String trackingNo;
  final String comDate;
  final String comTime;
  var paymentImg;

  Order({
    required this.orderTime,
    required this.orderDate,
    required this.orderDetails,
    required this.amount,
    required this.shippingFee,
    required this.orderID,
    required this.status,
    required this.trackingNo,
    required this.comDate,
    required this.comTime,
    required this.shippedDate,
    required this.shippedTime,
    required this.paymentImg,
  });

}
