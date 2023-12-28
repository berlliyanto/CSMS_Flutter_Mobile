import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaning/controllers/cleaning_controller.dart';
import 'package:flutter_mobile_csms/app/routes/app_pages.dart';
import 'package:flutter_mobile_csms/app/widgets/card.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';

Widget cleaningManagement(CleaningController controller){
  return Container(
    height: double.infinity,
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text(
              "Cleaning", 24, Colors.black87, FontWeight.bold, TextAlign.start),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
              "Total : ${controller.countAssign.total}", 14, Colors.grey, FontWeight.bold, TextAlign.start),
              text(
              "Verified : ${controller.countAssign.finish}", 14, Colors.green, FontWeight.bold, TextAlign.start),
              text(
              "Not Verified : ${controller.countAssign.notFinish}", 14, Colors.red, FontWeight.bold, TextAlign.start),
            ],
          ),
          const Divider(),
          cardNavigation(Routes.CLEANING_DATA, "Riwayat Cleaning"),
          const Divider(),
        ],
      ),
    ),
  );
}