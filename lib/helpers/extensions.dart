import 'package:flutter/material.dart';

extension Extra on TimeOfDay {
  String formattedTime() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}
