import 'package:get/get.dart';

import '../controllers/assestment_controller.dart';

class AssestmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssestmentController>(
      () => AssestmentController(),
    );
  }
}
