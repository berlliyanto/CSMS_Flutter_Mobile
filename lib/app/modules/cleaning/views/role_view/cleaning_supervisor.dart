import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaning/controllers/cleaning_controller.dart';
import 'package:flutter_mobile_csms/app/routes/app_pages.dart';
import 'package:flutter_mobile_csms/app/widgets/card.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';

Widget cleaningSupervisor(CleaningController controller){
  return Container(
    height: double.infinity,
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text(
              "Cleaning", 24, Colors.black87, FontWeight.bold, TextAlign.start),
          const Gap(10),
          cardNavigation(Routes.CLEANING_DATA, "Lihat Riwayat Cleaning"),
          const Divider(),
          const Gap(10),
          text(
              "Menunggu Verifikasi", 20, Colors.black87, FontWeight.bold, TextAlign.start),
        ],
      ),
    ),
  );
}