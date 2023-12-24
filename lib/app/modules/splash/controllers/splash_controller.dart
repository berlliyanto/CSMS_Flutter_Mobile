import 'package:flutter_mobile_csms/app/routes/app_pages.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    if (await Permission.notification.isDenied) {
      final notif = await Permission.notification.request();
      if (notif.isGranted) {
        Fluttertoast.showToast(msg: "Permission Granted");
      } else {
        Fluttertoast.showToast(msg: "Permission Denied");
      }
    }
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(Routes.LOGIN);
    });
  }
}
