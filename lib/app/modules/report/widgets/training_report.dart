
import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/report/controllers/tr_controller.dart';
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

class TrainingReport extends StatelessWidget {
  TrainingReport({super.key});

  final controller = Get.put(TrainingReportController());

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayPro(
    isLoading: controller.isLoading.value,
    child: Container(),
  );
  }
}