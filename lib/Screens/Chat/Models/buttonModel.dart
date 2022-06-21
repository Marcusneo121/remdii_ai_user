import 'package:flutter/cupertino.dart';

class Buttons {
  String title;
  String payload;

  Buttons({
    required this.title,
    required this.payload,
  });

  factory Buttons.fromJson(Map<String, dynamic> parsedJson) {
    return Buttons(title: parsedJson['title'], payload: parsedJson['payload']);
  }
}
