import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/models/location_model.dart';
import 'package:flutter_mobile_csms/app/models/user_model.dart';
import 'package:flutter_mobile_csms/app/modules/assestment/controllers/assestment_controller.dart';
import 'package:flutter_mobile_csms/app/modules/assestment/widgets/form_assestment.dart';
import 'package:flutter_mobile_csms/app/widgets/button.dart';
import 'package:flutter_mobile_csms/app/widgets/dialog.dart';
import 'package:flutter_mobile_csms/app/widgets/dropdown.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

Widget assestmentLeader(AssestmentController controller) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Gap(10),
      text(
          "Pilih Lokasi", 14, Colors.black87, FontWeight.bold, TextAlign.start),
      const Gap(10),
      dropdown(
          const Key("ass_location"),
          controller.location,
          "Pilih Lokasi",
          "Lokasi",
          (LocationModel model) => model.name.toString(),
          (LocationModel model) => model.id.toString(), (selected) {
        final id = selected.map((e) => e.value);
        final newId = id.isNotEmpty ? id.first : 0;
        controller.idLoc.value = int.parse(newId.toString());
        controller.assestData['location'] = int.parse(newId.toString());
        controller.update();
      }),
      const Gap(10),
      text("Pilih Cleaner", 14, Colors.black87, FontWeight.bold,
          TextAlign.start),
      const Gap(10),
      dropdown(
          const Key("ass_cleaner"),
          controller.cleaner,
          "Pilih Cleaner",
          "Cleaner",
          (CleanerModel model) => model.name.toString(),
          (CleanerModel model) => model.id.toString(), (selected) {
        final id = selected.map((e) => e.value);
        final newId = id.isNotEmpty ? id.first : 0;
        controller.idCleaner.value = int.parse(newId.toString());
        controller.assestData['cleaner'] = int.parse(newId.toString());
        controller.update();
      }),
      const Gap(20),
      GetBuilder<AssestmentController>(builder: (builder) {
        return builder.idCleaner.value != 0 && builder.idLoc.value != 0
            ? formAssestment(controller)
            : Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: text("Silahkan pilih lokasi dan cleaner", 16,
                      Colors.black87, FontWeight.bold, TextAlign.center),
                ),
              );
      }),
      const Gap(20),
      Center(
        child: Obx(
          () => controller.idCleaner.value != 0 && controller.idLoc.value != 0
              ? buttonPrimary(
                  "Submit",
                  () => dialog(
                      "Info",
                      "Pastikan Data Sudah Benar",
                      "Ya, Data Sudah Benar",
                      "Batal",
                      () => controller.postDataAssestment()),
                )
              : const SizedBox(),
        ),
      ),
    ],
  );
}
