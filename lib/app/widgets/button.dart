import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';

Widget buttonPrimary(String title, VoidCallback onPressed) {
  return ElevatedButton(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(5),
      backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 50,
        ),
      ),
    ),
    onPressed: onPressed,
    child: text(title, 20, Colors.white, FontWeight.bold, TextAlign.center),
  );
}
