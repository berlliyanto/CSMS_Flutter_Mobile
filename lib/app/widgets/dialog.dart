import 'package:flutter/material.dart';
import 'package:get/get.dart';

dialog(String title, String message, String messageOk, String messageClose,
    VoidCallback submit) {
  return Get.dialog(
    AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(messageClose),
        ),
        TextButton(
          onPressed: submit,
          child: Text(messageOk),
        ),
      ],
    ),
  );
}
