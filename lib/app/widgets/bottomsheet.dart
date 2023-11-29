import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningDetail/controllers/cleaning_detail_controller.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

bottomSheetImage(CleaningDetailController controller, String tipe) {
  return Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(15),
      height: 120,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => controller
                .getImage(ImageSource.camera, tipe)
                .then((value) => Get.back()),
            child: Container(
              color: Colors.white,
              width: Get.width,
              child: Row(
                children: [
                  const Icon(Icons.camera_alt, size: 32, color: Colors.blueGrey),
                  const Gap(5),
                  text("Camera", 16, Colors.black87, FontWeight.normal,
                      TextAlign.start)
                ],
              ),
            ),
          ),
          const Gap(10),
          GestureDetector(
            onTap: () => controller
                .getImage(ImageSource.gallery, tipe)
                .then((value) => Get.back()),
            child: Container(
              color: Colors.white,
              width: Get.width,
              child: Row(
                children: [
                  const Icon(Icons.image, size: 32, color: Colors.blueGrey),
                  const Gap(5),
                  text("Gallery", 16, Colors.black87, FontWeight.normal,
                      TextAlign.start)
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
  );
}
