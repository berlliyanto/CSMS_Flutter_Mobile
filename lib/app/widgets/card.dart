import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:get/get.dart';


Widget cardNavigation(String route, String title) {
  return GestureDetector(
    onTap: () => Get.toNamed(route),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 70,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepOrange.shade300,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text(title, 18, Colors.black87, FontWeight.bold, TextAlign.start),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.black87,
          )
        ],
      ),
    ),
  );
}
