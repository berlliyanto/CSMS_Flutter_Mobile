import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/models/task_by_leader_model.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_leader_service.dart';
import 'package:flutter_mobile_csms/app/widgets/dialog.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get.dart';

class SubCleaningAssignmentController extends GetxController {
  final TextEditingController cleanerName = TextEditingController();

  int argId = Get.arguments['id'];
  var isLoading = false.obs;

  Rx<TaskByLeaderModel> task = TaskByLeaderModel().obs;
  RxList cleaners = [].obs;

  Future<TaskByLeaderModel> showTaskLeader() async {
    isLoading.value = true;
    update();
    final response = await CleaningLeaderService().showCleaning(argId);
    TaskByLeaderModel task = response.body != null
        ? TaskByLeaderModel.fromJson(response.body['data'])
        : TaskByLeaderModel();
    isLoading.value = false;
    update();
    return task;
  }

  void saveCleaner() {
    task.value.tasksDetail
        ?.map((e) => {cleaners.add(e.cleaner!.name!)})
        .toList();
    update();
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

  void openDialogEdit() {
    formDialog(this, "Ubah Assignment", "", "Submit", "Batal", () {});
  }

  @override
  void onInit() async {
    super.onInit();
    task.value = await showTaskLeader();
    saveCleaner();
  }
}
