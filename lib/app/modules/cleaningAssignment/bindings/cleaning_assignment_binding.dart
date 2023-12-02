import 'package:get/get.dart';

import '../controllers/cleaning_assignment_controller.dart';

class CleaningAssignmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CleaningAssignmentController>(
      () => CleaningAssignmentController(),
    );
  }
}
