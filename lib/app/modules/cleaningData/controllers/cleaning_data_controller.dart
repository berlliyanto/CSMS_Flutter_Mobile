import 'package:flutter_mobile_csms/app/data/datatable_cleaningData.dart';
import 'package:flutter_mobile_csms/app/models/task_by_cleaner_model.dart';
import 'package:flutter_mobile_csms/app/models/task_model.dart';
import 'package:flutter_mobile_csms/app/services/Tasks/tasks_service.dart';
import 'package:get/get.dart';

class CleaningDataController extends GetxController {
  final DataTableTask source = DataTableTask();

  var isLoading = false.obs;
  TaskPaginateModel taskPaginate = TaskPaginateModel();

  Future<List<TasksByCleanerModel>> getAllTasks(int page) async {
    isLoading.value = true;
    update();
    final response = await TaskService().getAllTasks(page);
    List<TasksByCleanerModel> task = [];
    if( response.body != null ){
    task =  (response.body['data'] as List)
            .map((e) => TasksByCleanerModel.fromJson(e))
            .toList();
    // taskPaginate = TaskPaginateModel.fromJson(response.body['data']);  
    } else {
      // taskPaginate = TaskPaginateModel();
      task = [];
    }

    isLoading.value = false;
    update();
    return task;
  }

  void fetchDataTask(int page) async {
    source.updateDataFromController(await getAllTasks(page));
    //source.updatePaginate(taskPaginate.total!, taskPaginate.perPage!, taskPaginate.currentPage!);
  }

  @override
  void onInit() {
    super.onInit();
    fetchDataTask(1);
    source.getRole();
  }

}
