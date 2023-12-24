import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_mobile_csms/app/models/count_assign_model.dart';
import 'package:flutter_mobile_csms/app/models/task_assignment_model.dart';
import 'package:flutter_mobile_csms/app/routes/app_pages.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_assignment_service.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_danone_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class UserVerificationController extends GetxController {
  CountAssignModel countAssign =
      CountAssignModel(total: 0, finish: 0, notFinish: 0);
  List<TaskAssignmentModel> assignByDanone = [];

  var isLoading = false.obs;

  void showToast(String msg) => Fluttertoast.showToast(msg: msg);

  //QR SCANNER
  Future<void> scanQR() async {
    String qrValue;

    try {
      qrValue = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if (qrValue != "-1") {
        if (qrValue.contains("CS")) {
          List<String> newQrValue = qrValue.split("-");
          if (newQrValue[1].startsWith("CS")) {
            showToast("Berhasil Scan QR");
            Get.toNamed(Routes.CLEANING_ASSIGNMENT_DETAIL,
                arguments: {'id': int.parse(newQrValue[0])});
          } else {
            showToast("QR Code Tidak Valid");
          }
        }else{
          showToast("QR Code Tidak Valid");
        }
      } else {
        showToast("Gagal Scan QR");
      }
    } on PlatformException {
      qrValue = 'Failed';
      showToast("Something Wrong");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  //API
  Future getCountAssignment() async {
    final response = await CleaningAssignmentService().getCountAssignment();
    if (response.statusCode == 200) {
      countAssign = response.data != null
          ? CountAssignModel.fromJson(response.data['data'])
          : CountAssignModel(total: 0, finish: 0, notFinish: 0);
    }
  }

  Future getAssignByDanone() async {
    final response = await CleaningDanoneService().getByDanone();
    assignByDanone = response.data != null
        ? (response.data['data'] as List)
            .map((e) => TaskAssignmentModel.fromJson(e))
            .toList()
        : [];

    update();
  }

  Future<void> fetchAllAPI() async {
    isLoading.value = true;
    update();

    await getCountAssignment();
    await getAssignByDanone();

    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllAPI();
  }
}
