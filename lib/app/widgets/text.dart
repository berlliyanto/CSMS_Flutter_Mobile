
import 'package:flutter/widgets.dart';

Text text(String text, double size, Color color, FontWeight fontWeight, TextAlign textAlign) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      color: color,
      fontWeight: fontWeight
    ),
  );
}
