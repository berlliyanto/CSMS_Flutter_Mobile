import 'package:flutter_mobile_csms/app/models/task_by_leader_model.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_leader_service.dart';
import 'package:get/get.dart';

class SubCleaningAssignmentController extends GetxController {
  int argId = Get.arguments['id'];
  var isLoading = false.obs;

  Rx<TaskByLeaderModel> task = TaskByLeaderModel().obs;

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

  @override
  void onInit() async {
    super.onInit();
    task.value = await showTaskLeader();
  }

}
