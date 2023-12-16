import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

Widget cardProfile(ProfileController controller) {
  return Container(
    width: Get.width,
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
        text("ID :", 12, Colors.black87, FontWeight.bold, TextAlign.start),
        wrapTextProfile(controller.profile.id.toString()),
        const Gap(5),
        text("Nama :", 12, Colors.black87, FontWeight.bold, TextAlign.start),
        wrapTextProfile(controller.profile.name),
        const Gap(5),
        text(
            "Username :", 12, Colors.black87, FontWeight.bold, TextAlign.start),
        wrapTextProfile(controller.profile.username),
        const Gap(5),
        text("Email :", 12, Colors.black87, FontWeight.bold, TextAlign.start),
        wrapTextProfile(controller.profile.email),
        const Gap(5),
        text("Role :", 12, Colors.black87, FontWeight.bold, TextAlign.start),
        wrapTextProfile(controller.profile.role.roleName),
      ],
    ),
  );
}

Container wrapTextProfile(String title) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    width: Get.width,
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.1),
      borderRadius: BorderRadius.circular(5),
    ),
    child: text(title, 18, Colors.black87, FontWeight.normal, TextAlign.start),
  );
}
