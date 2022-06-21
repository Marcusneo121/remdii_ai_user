import 'package:fyp/DB_Models/User.dart';

class DeliveryRecipient {
  final String deliveryID, orderID;
  final User user;

  DeliveryRecipient({
    required this.orderID,
    required this.deliveryID,
    required this.user,
  });

}