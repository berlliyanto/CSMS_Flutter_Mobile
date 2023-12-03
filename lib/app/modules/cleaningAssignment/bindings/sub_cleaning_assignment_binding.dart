import 'package:flutter_mobile_csms/app/modules/cleaningAssignment/controllers/sub_cleaning_assignment_controller.dart';
import 'package:get/get.dart';

class SubCleaningAssignmentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubCleaningAssignmentController>(
      () => SubCleaningAssignmentController(),
    );
  }
}