import 'package:flutter_mobile_csms/app/data/datatable_cleaning_data_assignment.dart';
import 'package:flutter_mobile_csms/app/data/datatable_cleaning_data_task.dart';
import 'package:flutter_mobile_csms/app/models/task_assignment_model.dart';
import 'package:flutter_mobile_csms/app/models/task_by_cleaner_model.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_assignment_service.dart';
import 'package:flutter_mobile_csms/app/services/Tasks/tasks_service.dart';
import 'package:get/get.dart';

class CleaningDataController extends GetxController {
  final DataTableTask source = DataTableTask();
  final DataTableAssignment sourceAssignment = DataTableAssignment();

  var isLoading = false.obs;

  Future<List<TasksByCleanerModel>> getAllTasks(int page) async {
    isLoading.value = true;
    update();
    final response = await TaskService().getAllTasks(page);
    List<TasksByCleanerModel> task = [];
    if( response.body != null ){
    task =  (response.body['data'] as List)
            .map((e) => TasksByCleanerModel.fromJson(e))
            .toList();
    } else {
      task = [];
    }

    isLoading.value = false;
    update();
    return task;
  }

  Future<List<TaskAssignmentModel>> getAllAssignment(int page) async {
    isLoading.value = true;
    update();
    final response = await CleaningAssignmentService().getAllAssignment();
    List<TaskAssignmentModel> task = [];
    if( response.body != null ){
    task =  (response.body['data'] as List)
            .map((e) => TaskAssignmentModel.fromJson(e))
            .toList();
    } else {
      task = [];
    }

    isLoading.value = false;
    update();
    return task;
  }

  void fetchDataTask(int page) async {
    sourceAssignment.updateDataFromController(await getAllAssignment(page));
    //source.updatePaginate(taskPaginate.total!, taskPaginate.perPage!, taskPaginate.currentPage!);
  }

  @override
  void onInit() {
    super.onInit();
    fetchDataTask(1);
    sourceAssignment.getRole();
  }

}
