import 'package:flutter/material.dart';

class RawDataSet {
  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });
  final String title;
  final Color color;
  final List<double> values;
}
