import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/routes/app_pages.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

Widget cardAssignDanone(String kode ,String lokasi, String area, String oleh, int id, bool status) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(10),
    width: Get.width,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text("Kode Tugas : $kode", 18, Colors.black87, FontWeight.bold,
            TextAlign.start),
        const Gap(5),
        text("Lokasi : $lokasi", 18, Colors.black87, FontWeight.bold,
            TextAlign.start),
        const Gap(5),
        text("Area : $area", 18, Colors.black87, FontWeight.bold,
            TextAlign.start),
        const Gap(5),
        text("Oleh : $oleh", 16, Colors.black87.withOpacity(0.5),
            FontWeight.normal, TextAlign.start),
        const Gap(10),
        const Divider(
          height: 1,
        ),
        const Gap(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: status ? "Sudah Selesai" : "Belum Selesai", style: TextStyle(fontSize: 14, color: (status ? Colors.green : Colors.grey).withOpacity(0.8), fontWeight: FontWeight.bold)),
              ]
            )),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.CLEANING_ASSIGNMENT_DETAIL, arguments: {
                "id": id
              }),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  text("Detail", 14, Colors.deepOrange,
                  FontWeight.bold, TextAlign.start),
                  const Icon(Icons.arrow_right_alt, color: Colors.deepOrange)
                ],
              )
            )
          ],
        )
      ],
    ),
  );
}