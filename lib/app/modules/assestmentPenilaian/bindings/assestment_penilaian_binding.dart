import 'package:get/get.dart';

import '../controllers/assestment_penilaian_controller.dart';

class AssestmentPenilaianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssestmentPenilaianController>(
      () => AssestmentPenilaianController(),
    );
  }
}
