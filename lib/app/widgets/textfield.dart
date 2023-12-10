import 'package:flutter/material.dart';

TextField textFieldNormal(
    String text, TextEditingController controller) {
  return TextField(
    controller: controller,
      decoration: InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.deepOrange),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.deepOrange, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    labelText: text,
    labelStyle: const TextStyle(color: Colors.deepOrange),
  ));
}
