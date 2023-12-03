import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningAssignment/controllers/sub_cleaning_assignment_controller.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningDetail/controllers/cleaning_detail_controller.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

Widget cardDetailA(SubCleaningAssignmentController builder) {
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
        const Gap(8),
        text("Lokasi : ${builder.task.value.location?.name}", 16,
            Colors.black87, FontWeight.normal, TextAlign.start),
        const Gap(8),
        text("Area : ${builder.task.value.area?.name}", 16, Colors.black87,
            FontWeight.normal, TextAlign.start),
        const Gap(8),
        text("Leader : ${builder.task.value.assignBy?.name}", 16,
            Colors.black87, FontWeight.normal, TextAlign.start),
        const Gap(8),
        text("Dibuat pada : ${builder.task.value.createdAt}", 16,
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
            children: (builder.task.value.tasks ?? []).map((e) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: text(
                    "${(builder.task.value.tasks ?? []).indexOf(e) + 1}. $e",
                    14,
                    Colors.black87,
                    FontWeight.normal,
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
