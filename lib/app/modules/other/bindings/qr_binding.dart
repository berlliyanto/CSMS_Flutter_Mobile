import 'package:flutter_mobile_csms/app/modules/other/controllers/qr_controller.dart';
import 'package:get/get.dart';

class QRBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(QRController());
  }
}
