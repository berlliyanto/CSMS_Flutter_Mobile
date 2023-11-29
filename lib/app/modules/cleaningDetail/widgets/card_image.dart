import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:get/get.dart';

Widget cardImage(File file, String title) {
  return Center(
    child: Container(
      width: Get.width * 0.8,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: FileImage(file), fit: BoxFit.fill),
      ),
    ),
  );
}

Widget cardNoImage(String status) {
  return Center(
    child: Container(
      width: Get.width * 0.8,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(image: NetworkImage("http://192.168.100.160:8080/api/images/5qILx8MuaGzVVy7iH78lGbTPLpMuRl.png"), fit: BoxFit.cover)
      ),
      child: Center(
          child: text("Belum ada gambar", 14, Colors.black87, FontWeight.normal,
              TextAlign.center)),
    ),
  );
}
