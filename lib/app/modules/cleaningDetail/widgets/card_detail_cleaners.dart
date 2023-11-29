import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningDetail/controllers/cleaning_detail_controller.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:get/get.dart';

Widget cardDetailCleaners(CleaningDetailController builder) {
  return Container(
    width: Get.width,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 5,
          offset: const Offset(0, 0),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text("Daftar Cleaner", 18, Colors.black87, FontWeight.bold,
            TextAlign.start),
        const Divider(),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: builder.cleaners.map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: text("${builder.cleaners.indexOf(e) + 1}. ${e.name}", 14,
                  Colors.black87, FontWeight.normal, TextAlign.start),
            );
          }).toList(),
        ),
      ],
    ),
  );
}
