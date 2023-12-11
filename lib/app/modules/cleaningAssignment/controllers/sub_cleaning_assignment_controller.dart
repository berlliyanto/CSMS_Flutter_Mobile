import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/models/task_by_leader_model.dart';
import 'package:flutter_mobile_csms/app/services/Auth/auth_service.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_leader_service.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_supervisor_service.dart';
import 'package:flutter_mobile_csms/app/widgets/dialog.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SubCleaningAssignmentController extends GetxController {
  final TextEditingController cleanerName = TextEditingController();

  int argId = Get.arguments['id'];
  var isLoading = false.obs;
  var role = "".obs;

  Rx<TaskByLeaderModel> task = TaskByLeaderModel().obs;

  Future<TaskByLeaderModel> showTaskLeader() async {
    final response = await CleaningLeaderService().showCleaning(argId);
    TaskByLeaderModel task = response.body != null
        ? TaskByLeaderModel.fromJson(response.body['data'])
        : TaskByLeaderModel();

    return task;
  }

  Future deleteCleaning() async {
    final response = await CleaningLeaderService().deleteCleaning(argId);
    if (response.statusCode == 200) {
      Get.back();
      snackBar("Sukses", response.body['message'], SnackPosition.TOP, 10,
          Colors.green.shade500, Colors.white);
    } else {
      snackBar("Error", "Something went wrong", SnackPosition.TOP, 10,
          Colors.red.shade400, Colors.white);
    }
  }

  Future updateBySupervisor() async {
    final response =
        await CleaningSupervisorService().updateBySupervisor(argId);
    if (response.statusCode == 200) {
      Get.back();
      snackBar("Sukses", response.body['message'], SnackPosition.TOP, 10,
          Colors.green.shade500, Colors.white);
    } else {
      snackBar("Error", response.body['message'], SnackPosition.TOP, 10,
          Colors.red.shade400, Colors.white);
    }
  }

  Future getRole() async {
    final box = GetStorage();
    String token = box.read('token');
    var response = await AuthService().profile(token);
    role.value =
        response.body != null ? response.body['data']['role']['role_name'] : "";
    update();
  }

  Future fetchAllAPI() async {
    isLoading.value = true;
    update();
    await getRole();
    task.value = await showTaskLeader();
    isLoading.value = false;
    update();
  }

  void openDialogEdit() {
    formDialog(this, "Ubah Assignment", "", "Submit", "Batal", () {});
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchAllAPI();
  }
}
