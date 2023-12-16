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

Widget customButton(String title, Color color, double vertical,
    double horizontal, VoidCallback onPressed) {
  return Material(
    borderRadius: BorderRadius.circular(10),
    elevation: 2,
    color: Colors.transparent,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        type: MaterialType.canvas,
        color: Colors.transparent,
        child: InkWell(
          highlightColor: const Color.fromARGB(255, 198, 46, 0),
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: vertical, horizontal: horizontal),
            child: Center(
              child: text(
                  title, 20, Colors.white, FontWeight.bold, TextAlign.center),
            ),
          ),
        ),
      ),
    ),
  );
}
