import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/assestment/controllers/assestment_controller.dart';
import 'package:flutter_mobile_csms/app/widgets/input_number.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';

Widget formAssestment(AssestmentController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //Perilaku
      text("Perilaku (20%)", 18, Colors.black87, FontWeight.bold,
          TextAlign.start),
      const Gap(10),
      text(
          "Sopan - 10", 16, Colors.black87, FontWeight.normal, TextAlign.start),
      const Gap(10),
      inputNumber(10, controller.assestData['plk_s'] ?? 0, (p0) {
        controller.assestData['plk_s'] = p0.toInt();
        controller.update();
      }),
      const Gap(10),
      text("Disiplin dalam bekerja - 10", 16, Colors.black87, FontWeight.normal,
          TextAlign.start),
      const Gap(10),
      inputNumber(10, controller.assestData['plk_ddb'] ?? 0, (p0) {
        controller.assestData['plk_ddb'] = p0.toInt();
        controller.update();
      }),
      const Gap(20),

      //Sikap
      text("Sikap (15%)", 18, Colors.black87, FontWeight.bold, TextAlign.start),
      const Gap(10),
      text("Mengutamakan pelayanan terhadap user - 3", 16, Colors.black87,
          FontWeight.normal, TextAlign.start),
      const Gap(10),
      inputNumber(3, controller.assestData['sik_mptu'] ?? 0, (p0) {
        controller.assestData['sik_mptu'] = p0.toInt();
        controller.update();
      }),
      const Gap(10),
      text("Kesetiaan terhadap perusahaan - 3", 16, Colors.black87,
          FontWeight.normal, TextAlign.start),
      const Gap(10),
      inputNumber(3, controller.assestData['sik_ktp'] ?? 0, (p0) {
        controller.assestData['sik_ktp'] = p0.toInt();
        controller.update();
      }),
      const Gap(10),
      text("Koordinasi dengan tim maupun atasan - 4", 16, Colors.black87,
          FontWeight.normal, TextAlign.start),
      const Gap(10),
      inputNumber(4, controller.assestData['sik_kdtma'] ?? 0, (p0) {
        controller.assestData['sik_kdtma'] = p0.toInt();
        controller.update();
      }),
      const Gap(10),
      text("Management waktu - 3", 16, Colors.black87, FontWeight.normal,
          TextAlign.start),
      const Gap(10),
      inputNumber(3, controller.assestData['sik_mw'] ?? 0, (p0) {
        controller.assestData['sik_mw'] = p0.toInt();
        controller.update();
      }),
      const Gap(10),
      text("Rasa memiliki terhadap perusahaan - 2", 16, Colors.black87,
          FontWeight.normal, TextAlign.start),
      const Gap(10),
      inputNumber(2, controller.assestData['sik_rmtp'] ?? 0, (p0) {
        controller.assestData['sik_rmtp'] = p0.toInt();
        controller.update();
      }),
      const Gap(20),

      //Penampilan
      text("Penampilan (15%)", 18, Colors.black87, FontWeight.bold,
          TextAlign.start),
      const Gap(10),
      text("Rapi - 5", 16, Colors.black87, FontWeight.normal, TextAlign.start),
      const Gap(10),
      inputNumber(5, controller.assestData['pnm_r'] ?? 0, (p0) {
        controller.assestData['pnm_r'] = p0.toInt();
        controller.update();
      }),
      const Gap(10),
      text("Menggunakan seragam lengkap dan ID card - 5", 16, Colors.black87,
          FontWeight.normal, TextAlign.start),
      const Gap(10),
      inputNumber(5, controller.assestData['pnm_mslc'] ?? 0, (p0) {
        controller.assestData['pnm_mslc'] = p0.toInt();
        controller.update();
      }),
      const Gap(10),
      text("Quality (kebersihan badan, bau badan) - 5", 16, Colors.black87,
          FontWeight.normal, TextAlign.start),
      const Gap(10),
      inputNumber(5, controller.assestData['pnm_q'] ?? 0, (p0) {
        controller.assestData['pnm_q'] = p0.toInt();
        
        controller.update();
      }),
      const Gap(20),

      //Tanggung Jawab
      text("Tanggung Jawab (20%)", 18, Colors.black87, FontWeight.bold,
          TextAlign.start),
      const Gap(10),
      text("Kehadiran tepat waktu - 3", 16, Colors.black87, FontWeight.normal,
          TextAlign.start),
      const Gap(10),
      inputNumber(3, controller.assestData['tj_ktw'] ?? 0, (p0) {
        controller.assestData['tj_ktw'] = p0.toInt();
        controller.update();
      }),
      const Gap(10),
      text("Ketepatan waktu dalam menyelesaikan pekerjaan - 5", 16,
          Colors.black87, FontWeight.normal, TextAlign.start),
      const Gap(10),
      inputNumber(5, controller.assestData['tj_kwdmp'] ?? 0, (p0) {
        controller.assestData['tj_kwdmp'] = p0.toInt();
        controller.update();
      }),
      const Gap(10),
      text("Kedisiplinan - 4", 16, Colors.black87, FontWeight.normal,
          TextAlign.start),
      const Gap(10),
      inputNumber(4, controller.assestData['tj_kd'] ?? 0, (p0) {
        controller.assestData['tj_kd'] = p0.toInt();
        controller.update();
      }),
      const Gap(10),
      text("Melaksanakan pekerjaan sesuai jobdesk - 4", 16, Colors.black87,
          FontWeight.normal, TextAlign.start),
      const Gap(10),
      inputNumber(4, controller.assestData['tj_mpsj'] ?? 0, (p0) {
        controller.assestData['tj_mpsj'] = p0.toInt();
        controller.update();
      }),
      const Gap(10),
      text("Menjaga properti perusahaan - 4", 16, Colors.black87,
          FontWeight.normal, TextAlign.start),
      const Gap(10),
      inputNumber(4, controller.assestData['tj_mpmp'] ?? 0, (p0) {
        controller.assestData['tj_mpmp'] = p0.toInt();
        controller.update();
      }),
      const Gap(20),

      //Kompetensi
      text("Kompetensi (30%)", 18, Colors.black87, FontWeight.bold,
          TextAlign.start),
      const Gap(10),
      text("Kreatifitas - 3", 16, Colors.black87, FontWeight.normal,
          TextAlign.start),
      const Gap(10),
      inputNumber(3, controller.assestData['kom_k'] ?? 0, (p0) {
        controller.assestData['kom_k'] = p0.toInt();
        controller.update();
      }),
      const Gap(10),
      text("Produktivitas - 6", 16, Colors.black87, FontWeight.normal,
          TextAlign.start),
      const Gap(10),
      inputNumber(6, controller.assestData['kom_p'] ?? 0, (p0) {
        controller.assestData['kom_p'] = p0.toInt();
        controller.update();
      }),
      const Gap(10),
      text("Kemampuan dalam bekerja - 6", 16, Colors.black87, FontWeight.normal,
          TextAlign.start),
      const Gap(10),
      inputNumber(6, controller.assestData['kom_kdb'] ?? 0, (p0) {
        controller.assestData['kom_kdb'] = p0.toInt();
        controller.update();
      }),
      const Gap(10),
      text("Pengetahuan tentang pekerjaan - 6", 16, Colors.black87,
          FontWeight.normal, TextAlign.start),
      const Gap(10),
      inputNumber(6, controller.assestData['kom_ptp'] ?? 0, (p0) {
        controller.assestData['kom_ptp'] = p0.toInt();
        controller.update();
      }),
      const Gap(10),
      text("Ketepatan mengambil keputusan - 3", 16, Colors.black87,
          FontWeight.normal, TextAlign.start),
      const Gap(10),
      inputNumber(3, controller.assestData['kom_kmk'] ?? 0, (p0) {
        controller.assestData['kom_kmk'] = p0.toInt();
        controller.update();
      }),
      const Gap(10),
      text("Skill - 6", 16, Colors.black87, FontWeight.normal, TextAlign.start),
      const Gap(10),
      inputNumber(6, controller.assestData['kom_s'] ?? 0, (p0) {
        controller.assestData['kom_s'] = p0.toInt();
        controller.update();
      }),
      const Gap(20),
    ],
  );
}
