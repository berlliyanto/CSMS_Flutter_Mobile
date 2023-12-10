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

formDialog<T>( GetxController controller, String title, String message, String messageOk, String messageClose,
    VoidCallback submit) {
  return Get.dialog(
    AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: Get.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(

            )
          ],
        )
      ),
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
