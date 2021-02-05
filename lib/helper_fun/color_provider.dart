import 'package:flutter/material.dart';

getColor(double percent) {
  if (percent < 25) {
    return Colors.red;
  } else if (percent < 50) {
    return Colors.orange;
  } else {
    return Colors.green;
  }
}
