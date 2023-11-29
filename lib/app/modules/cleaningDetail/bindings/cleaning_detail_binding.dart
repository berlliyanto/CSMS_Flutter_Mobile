import 'package:get/get.dart';

import '../controllers/cleaning_detail_controller.dart';

class CleaningDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CleaningDetailController>(
      () => CleaningDetailController(),
    );
  }
}
