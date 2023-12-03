import 'package:flutter_mobile_csms/app/models/task_by_cleaner_model.dart';
import 'package:flutter_mobile_csms/app/services/Tasks/tasks_by_cleaner_service.dart';
import 'package:get/get.dart';

class CleaningCleanerController extends GetxController {
  Future<List<AllTasksByCleanerModel>> getTaskByCleaner() async {
    final response = await TaskByCleanerService().allTaskByCleaner();
    List<AllTasksByCleanerModel> tasks = [];
    tasks = response.body != null
        ? (response.body['data'] as List)
            .map((e) => AllTasksByCleanerModel.fromJson(e))
            .toList()
        : [];
    update();
    return tasks;
  }
}
