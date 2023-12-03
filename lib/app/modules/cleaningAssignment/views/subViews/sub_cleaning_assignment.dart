import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningAssignment/controllers/sub_cleaning_assignment_controller.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningAssignment/widgets/card_detailA.dart';
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
                      text("Detail Assignment", 20, Colors.black87, FontWeight.bold, TextAlign.start),
                      const Gap(10),
                      cardDetailA(builder)
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
