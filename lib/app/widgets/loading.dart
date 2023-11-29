import 'package:flutter/material.dart';
import 'package:loading_overlay_pro/animations/bouncing_line.dart';

Widget loading() {
  return const LoadingBouncingLine.circle(
    backgroundColor: Colors.deepOrange,
    borderColor: Colors.deepOrange,
    borderSize: 3.0,
  );
}
