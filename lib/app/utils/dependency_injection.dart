import 'package:flutter_mobile_csms/app/modules/other/controllers/file_controller.dart';
import 'package:flutter_mobile_csms/app/utils/check_network.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
    Get.put<FileController>(FileController(), permanent: true);
  }
}