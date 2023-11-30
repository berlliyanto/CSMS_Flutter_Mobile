import 'package:flutter_mobile_csms/app/data/datatable_cleaningData.dart';
import 'package:flutter_mobile_csms/app/models/task_by_cleaner_model.dart';
import 'package:flutter_mobile_csms/app/services/Tasks/tasks_service.dart';
import 'package:get/get.dart';

class CleaningDataController extends GetxController {
  final DataTableTask source = DataTableTask();

  var isLoading = false.obs;

  Future<List<TasksByCleanerModel>> getAllTasks(int page) async {
    isLoading.value = true;
    update();
    final response = await TaskService().getAllTasks(page);
    List<TasksByCleanerModel> task = [];
    task = response.body != null
        ? (response.body['data']['data'] as List)
            .map((e) => TasksByCleanerModel.fromJson(e))
            .toList()
        : [];
    isLoading.value = false;
    update();
    return task;
  }

  void fetchDataTask(int page) async {
    source.updateDataFromController(await getAllTasks(page));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchDataTask(1);
  }

}
