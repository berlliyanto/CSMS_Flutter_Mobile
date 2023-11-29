import 'package:flutter/material.dart';
import 'package:get/get.dart';

snackBar(String title, String message, SnackPosition snackPosition,
    double margin, Color bgColor, Color textColor) {
  return Get.snackbar(title, message,
      snackPosition: snackPosition,
      margin: EdgeInsets.all(margin),
      backgroundColor: bgColor,
      colorText: textColor,
      );
}
