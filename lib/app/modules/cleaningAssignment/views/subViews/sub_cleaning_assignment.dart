import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningAssignment/controllers/sub_cleaning_assignment_controller.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningAssignment/widgets/card_detail_assignment.dart';
import 'package:flutter_mobile_csms/app/widgets/button.dart';
import 'package:flutter_mobile_csms/app/widgets/dialog.dart';
import 'package:flutter_mobile_csms/app/widgets/loading.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

class SubCleaningAssignmentView extends GetView<SubCleaningAssignmentController> {
  const SubCleaningAssignmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Assignment'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: GetBuilder<SubCleaningAssignmentController>(
          builder: (builder){
            return LoadingOverlayPro(
              isLoading: builder.isLoading.value,
              progressIndicator: loading(),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text("Detail Assignment", 24, Colors.black87, FontWeight.bold, TextAlign.start),
                      const Gap(10),
                      cardDetailA(builder),
                      const Gap(10),
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text("Daftar Cleaner", 16, Colors.black87, FontWeight.bold, TextAlign.start),
                            const Gap(8),
                            ...builder.cleaners.map((element) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: text("$element", 14, Colors.black87, FontWeight.normal, TextAlign.start),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                      const Gap(10),
                      customButton("Edit", Colors.yellow, 10, 20, () => builder.openDialogEdit()),
                      const Gap(8),
                      customButton("Hapus", Colors.red, 10, 20, () => dialog("Hapus", "Apakah anda yakin ingin menghapus data ini?", "Hapus", "Tidak", () => builder.deleteCleaning()))
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
