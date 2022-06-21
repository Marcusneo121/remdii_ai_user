import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp/DB_Models/OrderDetails.dart';

class ToShipOrderItemCard extends StatelessWidget {
  const ToShipOrderItemCard({Key? key, required this.orderDetails}) : super(key: key);

  final OrderDetails orderDetails;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: AspectRatio(
            aspectRatio: 0.85,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.memory(base64.decode(orderDetails.products.prod_img)),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderDetails.products.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "x ${orderDetails.qty}",
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  fontSize: 14.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "RM ${orderDetails.totalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w800,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
