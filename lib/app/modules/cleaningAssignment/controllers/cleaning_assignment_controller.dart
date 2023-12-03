import 'package:flutter_mobile_csms/app/models/task_by_leader_model.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_leader_service.dart';
import 'package:get/get.dart';

class CleaningAssignmentController extends GetxController {
  List<TaskByLeaderModel> listTask = [];
  var isLoading = false.obs;


  Future<List<TaskByLeaderModel>> getTaskLeader() async {
    isLoading.value = true;
    update();
    final response = await CleaningLeaderService().getCleaning();
    List<TaskByLeaderModel> task = [];
    task = response.body != null
        ? (response.body['data'] as List)
            .map((e) => TaskByLeaderModel.fromJson(e))
            .toList()
        : [];
    listTask = task;
    isLoading.value = false;
    update();
    return task;
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTaskLeader();
  }
}

