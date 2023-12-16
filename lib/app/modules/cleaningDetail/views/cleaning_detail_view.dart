
import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningDetail/widgets/card_detail_assignment.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningDetail/widgets/card_detail_cleaners.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningDetail/widgets/form_assignment.dart';
import 'package:flutter_mobile_csms/app/widgets/button.dart';
import 'package:flutter_mobile_csms/app/widgets/dialog.dart';
import 'package:flutter_mobile_csms/app/widgets/loading.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

import '../controllers/cleaning_detail_controller.dart';

class CleaningDetailView extends GetView<CleaningDetailController> {
  const CleaningDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tugas'),
        centerTitle: true,
      ),
      body: GetBuilder<CleaningDetailController>(
        builder: (builder) {
          return LoadingOverlayPro(
            isLoading: builder.isLoading.value,
            progressIndicator: loading(),
            child: GestureDetector(
              onTap: () =>  FocusManager.instance.primaryFocus?.unfocus(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(10),
                      text("Detail Tugas Anda", 20, Colors.black87,
                          FontWeight.bold, TextAlign.start),
                      const Gap(10),
                      cardDetailAssignment(builder),
                      const Gap(10),
                      cardDetailCleaners(builder),
                      const Gap(10),
                      builder.taskByCleaner.status == "Pending"
                          ? Center(
                              child: buttonPrimary(
                              "Kerjakan Tugas",
                              () => dialog(
                                  "Mulai mengerjakan ?",
                                  "Pastikan diri anda sudah siap",
                                  "Siap",
                                  "Belum Siap", () {
                                builder.updateStatusTask("On Progress");
                                Get.back();
                              }),
                            ))
                          : const SizedBox(),
                      if (builder.taskByCleaner.status != "Pending")
                      formAssignmentCleaner(controller)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
