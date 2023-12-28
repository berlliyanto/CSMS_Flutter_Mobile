import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/report/controllers/ar_controller.dart';
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

class AssestmentReport extends StatelessWidget {
  AssestmentReport({super.key});

  final controller = Get.put(AssestmentReportController());

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayPro(
      isLoading: controller.isLoading.value,
      child: Container(),
    );
  }
}
