import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningDetail/controllers/cleaning_detail_controller.dart';
import 'package:flutter_mobile_csms/app/widgets/bottomsheet.dart';
import 'package:flutter_mobile_csms/app/widgets/button.dart';
import 'package:flutter_mobile_csms/app/widgets/task_image.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

Widget formAssignmentCleaner(CleaningDetailController controller) {
  return Column(
    children: [
      Container(
        width: Get.width,
        padding: const EdgeInsets.all(10),
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
            text("Form Assignment", 18, Colors.black87, FontWeight.bold,
                TextAlign.start),
            const Divider(),

            //--------BEFORE----------//
            text("Gambar Sebelum", 14, Colors.black87, FontWeight.bold,
                TextAlign.right),
            const Gap(10),
            if (controller.imageBefore == null)
              cardImageAPI(controller.taskByCleaner.imageBefore)
            else
              cardImageCamera(controller.imageBefore!, "Belum ada gambar"),
            controller.taskByCleaner.status == "On Progress"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () =>
                              bottomSheetImage(controller, "before"),
                          child: const Text("Ambil Foto")),
                      TextButton(
                          onPressed: () => controller.deleteImage("before"),
                          child: const Text("Hapus"))
                    ],
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: text("Selesai", 14, Colors.black87,
                          FontWeight.w500, TextAlign.center),
                    ),
                  ),
            const Gap(10),

            //--------PROSES----------//
            text("Gambar Proses", 14, Colors.black87, FontWeight.bold,
                TextAlign.right),
            const Gap(10),
            if (controller.imageProgress == null)
              cardImageAPI(controller.taskByCleaner.imageProgress)
            else
              cardImageCamera(controller.imageProgress!, "Belum ada gambar"),
            controller.taskByCleaner.status == "On Progress"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () =>
                              bottomSheetImage(controller, "progress"),
                          child: const Text("Ambil Foto")),
                      TextButton(
                          onPressed: () => controller.deleteImage("progress"),
                          child: const Text("Hapus"))
                    ],
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: text("Selesai", 14, Colors.black87,
                          FontWeight.w500, TextAlign.center),
                    ),
                  ),
            const Gap(10),

            //--------SESUDAH----------//
            text("Gambar Sesudah", 14, Colors.black87, FontWeight.bold,
                TextAlign.right),
            const Gap(10),
            if (controller.imageFinish == null)
              cardImageAPI(controller.taskByCleaner.imageFinish)
            else
              cardImageCamera(controller.imageFinish!, "Belum ada gambar"),
            controller.taskByCleaner.status == "On Progress"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () =>
                              bottomSheetImage(controller, "finish"),
                          child: const Text("Ambil Foto")),
                      TextButton(
                          onPressed: () => controller.deleteImage("finish"),
                          child: const Text("Hapus"))
                    ],
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: text("Selesai", 14, Colors.black87,
                          FontWeight.w500, TextAlign.center),
                    ),
                  ),
            const Gap(10),

            //--------Catatan----------//
            controller.taskByCleaner.status == "On Progress"
                ? TextField(
              controller: controller.catatanController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText: 'Catatan (opsional)',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                // Lakukan sesuatu dengan teks yang diubah
              },
            ) : text("Catatan : ${controller.taskByCleaner.catatan ?? 'Tidak ada catatan'}", 16 , Colors.black87, FontWeight.normal, TextAlign.start),
            const Gap(10),
            if (controller.taskByCleaner.status == "On Progress")
            Center(
                child: TextButton(
                    onPressed: () {
                      controller.isNotFinish.value =
                          !controller.isNotFinish.value;
                      controller.update();
                    },
                    child: Text(
                      controller.isNotFinish.value
                          ? "Batalkan"
                          : "Tidak selesai?",
                      style: const TextStyle(fontSize: 20),
                    ))),
            controller.isNotFinish.value
                ? TextField(
                    controller: controller.alasanController,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      labelText: 'Tuliskan alasan tidak selesai disini',
                      border: OutlineInputBorder(),
                    ),
                  )
                : const SizedBox(),
            const Gap(10),
            if (controller.taskByCleaner.status == "On Progress")
            Center(
                child: buttonPrimary(
                    "Selesaikan", () => controller.updateFinishTask()))
          ],
        ),
      )
    ],
  );
}
