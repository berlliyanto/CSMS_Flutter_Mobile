import 'package:flutter_mobile_csms/app/models/task_assignment_model.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_supervisor_service.dart';
import 'package:get/get.dart';

class CleaningSupervisorController extends GetxController {
  Future<List<TaskAssignmentModel>> getTaskBySupervisor() async {
    final response = await CleaningSupervisorService().getBySupervisor();
    List<TaskAssignmentModel> tasks = [];
    tasks = response.body != null
        ? (response.body['data'] as List)
            .map((e) => TaskAssignmentModel.fromJson(e))
            .toList()
        : [];
    update();
    return tasks;
  }
}