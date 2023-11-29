import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningDetail/controllers/cleaning_detail_controller.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

Widget cardDetailAssignment(CleaningDetailController builder) {
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
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            text("Assignment", 18, Colors.black87, FontWeight.bold,
                TextAlign.start),
            Badge(
              largeSize: 25,
              padding: const EdgeInsets.all(3),
              label: text("${builder.taskByCleaner.status}", 14,
                  statusColor(builder.taskByCleaner.status), FontWeight.normal, TextAlign.center),
              backgroundColor: statusColor(builder.taskByCleaner.status).withOpacity(0.1),
            ),
          ],
        ),
        const Divider(),
        const Gap(8),
        text("Lokasi : ${builder.taskByCleaner.assign.location.locationName}",
            16, Colors.black87, FontWeight.normal, TextAlign.start),
        const Gap(8),
        text("Area : ${builder.taskByCleaner.assign.area.areaName}", 16,
            Colors.black87, FontWeight.normal, TextAlign.start),
        const Gap(8),
        text("Leader : ${builder.taskByCleaner.assign.assignBy.name}", 16,
            Colors.black87, FontWeight.normal, TextAlign.start),
        const Gap(8),
        text("Dibuat pada : ${builder.taskByCleaner.createdAt}", 16,
            Colors.black87, FontWeight.normal, TextAlign.start),
        const Gap(8),
        text("Tugas :", 16, Colors.black87, FontWeight.normal, TextAlign.start),
        const Gap(8),
        Container(
          width: Get.width,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(44, 255, 175, 121),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: builder.taskByCleaner.tasks.map((e) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: text("${builder.taskByCleaner.tasks.indexOf(e) + 1}. $e", 14, Colors.black87, FontWeight.normal,
                    TextAlign.start),
              );
            }).toList(),
          ),
        )
      ],
    ),
  );
}

Color statusColor(String status) {
  if (status == "On Progress") {
    return Colors.orange;
  } else if (status == "Finish") {
    return Colors.green;
  } else if (status == "Not Finish") {
    return Colors.red;
  }

  return Colors.grey;
}
