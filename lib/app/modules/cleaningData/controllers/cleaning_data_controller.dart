import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/data/datatable_cleaning_data_assignment.dart';
import 'package:flutter_mobile_csms/app/data/datatable_cleaning_data_task.dart';
import 'package:flutter_mobile_csms/app/models/task_assignment_model.dart';
import 'package:flutter_mobile_csms/app/models/task_by_cleaner_model.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_assignment_service.dart';
import 'package:flutter_mobile_csms/app/services/Tasks/tasks_service.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CleaningDataController extends GetxController {
  final DataTableTask source = DataTableTask();
  final DataTableAssignment sourceAssignment = DataTableAssignment();

  var isLoading = false.obs;
  var stateStartDate = false.obs;
  var stateEndDate = false.obs;
  RxString tipeFilter = "".obs;
  RxString formatedStartDate = "".obs;
  RxString formatedEndDate = "".obs;
  DateTime? startDate, endDate;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != startDate) {
      stateStartDate.value = true;
      startDate = picked;
    }

    if (startDate != null) {
      formatedStartDate.value = dateFormat.format(startDate!);
    }

    update();
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != endDate) {
      stateEndDate.value = true;
      endDate = picked;
    }

    if (endDate != null) {
      formatedEndDate.value = dateFormat.format(endDate!);
    }
    
    update();
  }


  Future<List<TasksByCleanerModel>> getAllTasks(int page) async {
    isLoading.value = true;
    update();
    final response = await TaskService().getAllTasks(page);
    List<TasksByCleanerModel> task = [];
    if (response.body != null) {
      task = (response.body['data'] as List)
          .map((e) => TasksByCleanerModel.fromJson(e))
          .toList();
    } else {
      task = [];
    }

    isLoading.value = false;
    update();
    return task;
  }

  Future<void> getFilteredAssignByDate() async {

    if(tipeFilter.value.isEmpty || formatedStartDate.value.isEmpty || formatedEndDate.value.isEmpty){
      snackBar("Warning", "Tipe dan tanggal tidak boleh kosong", SnackPosition.TOP, 10, const Color.fromARGB(255, 201, 181, 0), Colors.white);
      return;
    }

    isLoading.value = true;
    update();
    final response = await CleaningAssignmentService().getAssignmentFilterDate(tipeFilter.value, formatedStartDate.value, formatedEndDate.value);
    List<TaskAssignmentModel> task = [];
    if (response.body != null) {
      task = (response.body['data'] as List)
          .map((e) => TaskAssignmentModel.fromJson(e))
          .toList();
    } else {
      task = [];
    }

    sourceAssignment.updateDataFromController(task);
  
    isLoading.value = false;
    update();
  }

  Future<List<TaskAssignmentModel>> getAllAssignment() async {
    isLoading.value = true;
    update();
    final response = await CleaningAssignmentService().getAllAssignment();
    List<TaskAssignmentModel> task = [];
    if (response.body != null) {
      task = (response.body['data'] as List)
          .map((e) => TaskAssignmentModel.fromJson(e))
          .toList();
    } else {
      task = [];
    }

    isLoading.value = false;
    update();
    return task;
  }

  void fetchDataTask() async {
    sourceAssignment.updateDataFromController(await getAllAssignment());
    //source.updatePaginate(taskPaginate.total!, taskPaginate.perPage!, taskPaginate.currentPage!);
  }

  void refetch() async {
    fetchDataTask();
    sourceAssignment.getRole();

    tipeFilter.value = "";
    formatedStartDate.value = "";
    formatedEndDate.value = "";
    startDate = null;
    endDate = null;
  }

  @override
  void onInit() {
    super.onInit();
    fetchDataTask();
    sourceAssignment.getRole();
  }
}
