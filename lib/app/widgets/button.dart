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

Widget customButton(String title, Color color, double vertical, double horizontal, VoidCallback onPressed){
  return InkWell(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: text(title, 20, Colors.white, FontWeight.bold, TextAlign.center),
      ),
    ),
  );
}