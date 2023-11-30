import 'package:get/get.dart';

import '../controllers/cleaning_data_controller.dart';

class CleaningDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CleaningDataController>(
      () => CleaningDataController(),
    );
  }
}
