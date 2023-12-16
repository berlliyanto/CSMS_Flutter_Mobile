import 'package:flutter_mobile_csms/app/models/task_assignment_model.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_leader_service.dart';
import 'package:get/get.dart';

class CleaningAssignmentController extends GetxController {
  List<TaskAssignmentModel> listTask = [];
  var isLoading = false.obs;


  Future<List<TaskAssignmentModel>> getTaskLeader() async {
    isLoading.value = true;
    update();
    final response = await CleaningLeaderService().getCleaning();
    List<TaskAssignmentModel> task = [];
    task = response.body != null
        ? (response.body['data'] as List)
            .map((e) => TaskAssignmentModel.fromJson(e))
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

