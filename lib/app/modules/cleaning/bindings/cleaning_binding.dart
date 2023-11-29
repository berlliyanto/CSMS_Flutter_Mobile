import 'package:get/get.dart';

import '../controllers/cleaning_controller.dart';

class CleaningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CleaningController>(
      () => CleaningController(),
    );
  }
}
