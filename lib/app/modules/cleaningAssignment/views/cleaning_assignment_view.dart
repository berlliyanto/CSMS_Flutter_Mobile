import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningAssignment/widgets/list_card_assignment.dart';
import 'package:flutter_mobile_csms/app/widgets/loading.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

import '../controllers/cleaning_assignment_controller.dart';

class CleaningAssignmentView extends GetView<CleaningAssignmentController> {
  const CleaningAssignmentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Assignment Saya'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                controller.getTaskLeader();
              },
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        body: GetBuilder<CleaningAssignmentController>(builder: (builder) {
          return RefreshIndicator(
            onRefresh: () async {
              builder.getTaskLeader();
            },
            child: LoadingOverlayPro(
              isLoading: builder.isLoading.value,
              progressIndicator: loading(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text("Assignment Aktif", 20, Colors.black87,
                          FontWeight.bold, TextAlign.start),
                      const Gap(10),
                      listCardAssignment(builder),
                      const Gap(10),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
