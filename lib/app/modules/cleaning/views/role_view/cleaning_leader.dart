import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/models/area_model.dart';
import 'package:flutter_mobile_csms/app/models/location_model.dart';
import 'package:flutter_mobile_csms/app/models/user_model.dart';
import 'package:flutter_mobile_csms/app/modules/cleaning/controllers/cleaning_controller.dart';
import 'package:flutter_mobile_csms/app/routes/app_pages.dart';
import 'package:flutter_mobile_csms/app/widgets/card.dart';
import 'package:flutter_mobile_csms/app/widgets/dropdown.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:flutter_mobile_csms/app/widgets/textfield.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

Widget cleaningLeader(CleaningController controller) {
  return Container(
    height: double.infinity,
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text(
              "Cleaning", 24, Colors.black87, FontWeight.bold, TextAlign.start),
          const Gap(10),
          cardNavigation(Routes.CLEANING_ASSIGNMENT, "Lihat Assignment Saya"),
          const Gap(10),
          cardNavigation(Routes.CLEANING_DATA, "Lihat Riwayat Cleaning"),
          const Divider(),
          const Gap(10),
          text("Beri Tugas", 20, Colors.black87, FontWeight.w800,
              TextAlign.start),
          const Gap(10),
          text("Lokasi Cleaning", 16, Colors.black87, FontWeight.w800,
              TextAlign.start),
          const Gap(10),
          dropdown(
              const Key("clean_location"),
              controller.location,
              "Pilih Lokasi",
              "Lokasi",
              (LocationModel model) => model.name.toString(),
              (LocationModel model) => model.id.toString(), (selected) async {
            final id = selected.map((e) => e.value);
            final newId = id.isNotEmpty ? id.first : 0;
            controller.locationId.value = int.parse(newId.toString());
            controller.update();
            controller.area = await controller.cleaningLeaderController
                .getAreasByLocation(int.parse(newId.toString()));
            controller.update();
          }),
          const Gap(10),
          text("Area Cleaning", 16, Colors.black87, FontWeight.w800,
              TextAlign.start),
          const Gap(10),
          controller.locationId > 0
              ? dropdown(
                  const Key("clean_area"),
                  controller.area,
                  "Pilih Area",
                  "Area",
                  (AreaModel model) => model.name.toString(),
                  (AreaModel model) => model.id.toString(), (selected) {
                  final id = selected.map((e) => e.value);
                  final newId = id.isNotEmpty ? id.first : 0;
                  controller.areaId.value = int.parse(newId.toString());
                  controller.update();
                })
              : Container(
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: Center(
                      child: text("Pilih lokasi terlebih dahulu", 14,
                          Colors.black87, FontWeight.normal, TextAlign.center)),
                ),
          const Gap(10),
          text("Nama Cleaner", 16, Colors.black87, FontWeight.w800,
              TextAlign.start),
          const Gap(10),
          dropdownMultiSelection(
              const Key("clean_cleaner"),
              controller.cleaner,
              'Pilih Cleaner',
              'Cleaner',
              (UserModel model) => model.name.toString(),
              (UserModel model) => model.id.toString(), (selected) {
            controller.cleanersSelected.value =
                selected.map((e) => e.value).toList();
            controller.update();
          }),
          const Gap(10),
          text("Tugas", 16, Colors.black87, FontWeight.w800, TextAlign.start),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width * 0.7,
                child: textFieldNormal("Beri Tugas", controller.task),
              ),
              GestureDetector(
                onTap: () => controller.addTask(),
                child: Container(
                  width: Get.width * 0.15,
                  height: Get.width * 0.15,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GetBuilder<CleaningController>(
            builder: (builder) {
              return Column(
                children: builder.tasks.asMap().entries.map((entry) {
                  final index = entry.key;
                  final element = entry.value;
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(5),
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        text(element, 14, Colors.black87, FontWeight.normal,
                            TextAlign.start),
                        GestureDetector(
                          onTap: () => controller.deleteTask(index),
                          child: const Icon(Icons.delete),
                        )
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 50,
                  ))),
              onPressed: () => controller.submitTask(controller.areaId.value,
                  controller.locationId.value, controller.cleanersSelected),
              child: text("Submit", 20, Colors.white, FontWeight.bold,
                  TextAlign.center),
            ),
          ),
        ],
      ),
    ),
  );
}
