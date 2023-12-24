import 'package:flutter_mobile_csms/app/modules/other/controllers/file_controller.dart';
import 'package:get/get.dart';

class FileBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(FileController());
  }
}