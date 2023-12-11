import 'package:flutter_mobile_csms/app/models/task_by_leader_model.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_supervisor_service.dart';
import 'package:get/get.dart';

class CleaningSupervisorController extends GetxController {
  Future<List<TaskByLeaderModel>> getTaskBySupervisor() async {
    final response = await CleaningSupervisorService().getBySupervisor();
    List<TaskByLeaderModel> tasks = [];
    tasks = response.body != null
        ? (response.body['data'] as List)
            .map((e) => TaskByLeaderModel.fromJson(e))
            .toList()
        : [];
    update();
    return tasks;
  }
}