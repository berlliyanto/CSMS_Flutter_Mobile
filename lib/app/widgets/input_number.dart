import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/assestment/controllers/assestment_controller.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

Widget inputNumber(int maxVal, int val, Function(dynamic) onChanged) {
  return GetBuilder<AssestmentController>(
    builder: (_) {
      return NumberPicker(
        minValue: 0, 
        maxValue: maxVal, 
        value: val, 
        onChanged: onChanged,
        axis: Axis.horizontal,
        haptics: true,
        itemHeight: 50,
      ); 
    },
      );
}
