import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningAssignment/controllers/cleaning_assignment_detail_controller.dart';
import 'package:flutter_mobile_csms/app/widgets/task_image.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

Widget cardFormAssignment(CleaningAssignmentDetailController controller) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
          )
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width,
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: (controller.task.value.tasksDetail ?? [])
                  .map((e) => badgeNameCleaner(
                      controller,
                      e.cleaner!.name!,
                      e.id!,
                      e.imageBefore,
                      e.imageProgress,
                      e.imageFinish,
                      e.status,
                      e.catatan,
                      e.alasan))
                  .toList(),
            ),
          ),
        ),
        const Divider(),
        controller.selectedCleaner.value == 0
            ? const Center(
                child: Text("No cleaner selected"),
              )
            : listTaskImage(controller.urlBefore, controller.urlProgress,
                controller.urlFinish),
        const Divider(),
        text(
            "Status :", 16, Colors.black87, FontWeight.bold, TextAlign.start),
        text("${controller.status}", 16, Colors.black87, FontWeight.normal,
            TextAlign.start),
        const Gap(5),
        text("Catatan :", 16, Colors.black87, FontWeight.bold,
            TextAlign.start),
        text("${controller.catatan ?? "-"}", 16, Colors.black87, FontWeight.normal,
            TextAlign.start),
        const Gap(5),
        text("Alasan Tidak Selesai :", 16, Colors.black87, FontWeight.bold,
            TextAlign.start),
        text("${controller.alasan ?? "-"}", 16, Colors.black87, FontWeight.normal,
            TextAlign.start),
      ],
    ),
  );
}

GestureDetector badgeNameCleaner(
    CleaningAssignmentDetailController controller,
    String name,
    int id,
    dynamic urlBefore,
    dynamic urlProgress,
    dynamic urlAFinish,
    dynamic status,
    dynamic catatan,
    dynamic alasan) {
  return GestureDetector(
    onTap: () {
      controller.selectedCleaner.value = id;
      controller.urlBefore = urlBefore;
      controller.urlProgress = urlProgress;
      controller.urlFinish = urlAFinish;
      controller.status = status;
      controller.catatan = catatan;
      controller.alasan = alasan;
      controller.update();
    },
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: id == controller.selectedCleaner.value
            ? const Color.fromARGB(44, 255, 175, 121)
            : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(name),
      ),
    ),
  );
}

SizedBox listTaskImage(
    dynamic urlBefore, dynamic urlProgress, dynamic urlAFinish) {
  return SizedBox(
    width: Get.width,
    child: Column(children: [
      //--------BEFORE----------//
      text("Gambar Sebelum", 14, Colors.black87, FontWeight.bold,
          TextAlign.right),
      const Gap(10),
      cardImageAPI(urlBefore),
      const Gap(10),

      //--------PROSES----------//
      text("Gambar Proses", 14, Colors.black87, FontWeight.bold,
          TextAlign.right),
      const Gap(10),
      cardImageAPI(urlProgress),
      const Gap(10),

      //--------SESUDAH----------//
      text("Gambar Sesudah", 14, Colors.black87, FontWeight.bold,
          TextAlign.right),
      const Gap(10),
      cardImageAPI(urlAFinish)
    ]),
  );
}
