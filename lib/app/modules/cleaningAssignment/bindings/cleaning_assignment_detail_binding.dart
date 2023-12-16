import 'package:flutter_mobile_csms/app/modules/cleaningAssignment/controllers/cleaning_assignment_detail_controller.dart';
import 'package:get/get.dart';

class CleaningAssignmentDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CleaningAssignmentDetailController>(
      () => CleaningAssignmentDetailController(),
    );
  }
}