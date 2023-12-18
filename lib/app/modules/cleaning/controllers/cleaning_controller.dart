import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/models/area_model.dart';
import 'package:flutter_mobile_csms/app/models/count_assign_model.dart';
import 'package:flutter_mobile_csms/app/models/location_model.dart';
import 'package:flutter_mobile_csms/app/models/task_by_cleaner_model.dart';
import 'package:flutter_mobile_csms/app/models/task_assignment_model.dart';
import 'package:flutter_mobile_csms/app/models/user_model.dart';
import 'package:flutter_mobile_csms/app/modules/cleaning/views/role_view/cleaning_cleaner.dart';
import 'package:flutter_mobile_csms/app/modules/cleaning/views/role_view/cleaning_danone.dart';
import 'package:flutter_mobile_csms/app/modules/cleaning/views/role_view/cleaning_leader.dart';
import 'package:flutter_mobile_csms/app/modules/cleaning/views/role_view/cleaning_supervisor.dart';
import 'package:flutter_mobile_csms/app/services/Auth/auth_service.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_assignment_service.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_leader_service.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_supervisor_service.dart';
import 'package:flutter_mobile_csms/app/services/Location_Area/area_service.dart';
import 'package:flutter_mobile_csms/app/services/Location_Area/location_service.dart';
import 'package:flutter_mobile_csms/app/services/Tasks/tasks_by_cleaner_service.dart';
import 'package:flutter_mobile_csms/app/services/Users/cleaner_service.dart';
import 'package:flutter_mobile_csms/app/widgets/loading.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

class CleaningController extends GetxController {

  TextEditingController task = TextEditingController();

  List<UserModel> cleaner = [];
  List<LocationModel> location = [];
  List<AreaModel> area = [];
  List<AllTasksByCleanerModel> tasksByCleaner = [];
  List<TaskAssignmentModel> tasksBySupervisor = [];

  CountAssignModel countAssign = CountAssignModel(total: 0, finish: 0, notFinish: 0);

  RxList tasks = [].obs;
  RxList cleanersSelected = [].obs;
  RxInt locationId = 0.obs;
  RxInt areaId = 0.obs;
  RxString tasksSeparated = ''.obs;
  RxString role = ''.obs;
  RxBool isLoading = false.obs;

  // ---------------------- User Operation

  void addTask() {
    if (task.text != '') {
      tasks.add(task.text);
      task.clear();
    }
    update();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    update();
  }

  Future submitTask(int area, int lokasi, List cleaners) async {
    if (area <= 0 || lokasi <= 0 || cleaners.isEmpty || tasks.isEmpty) {
      snackBar("Peringatan", "Semua field harus terisi", SnackPosition.TOP, 10,
          Colors.red.shade500.withOpacity(0.8), Colors.white);
      return;
    }
    tasksSeparated.value = tasks.join("|");
    Map<String, dynamic> data = {
      "area_id": area,
      "cleaners": cleaners,
      "task": tasksSeparated.value
    };

    isLoading.value = true;
    update();

    final response = await CleaningLeaderService().postCleaning(data);
    if(response.statusCode ==200){
      Get.back();
      snackBar("Sukses", "Berhasil simpan data", SnackPosition.TOP, 10,
          Colors.green.shade500, Colors.white);
    }else{
      snackBar("Error", "Something went wrong", SnackPosition.TOP, 10,
          Colors.red.shade400, Colors.white);
    }

    isLoading.value = false;
    update();
  }

  // ---------------------- API Operation

  Future getRole() async {
    final box = GetStorage();
    String token = box.read('token');
    var value = await AuthService().profile(token);
    role.value = value.data != null ? value.data['data']['role']['role_name'] : '';
    update();
  }

  Future getCountAssignment() async {
    final response = await CleaningAssignmentService().getCountAssignment();
    if (response.statusCode == 200) {
      countAssign = response.data != null ? CountAssignModel.fromJson(response.data['data']) : CountAssignModel(total: 0, finish: 0, notFinish: 0);
    }
  }

  Future fetchAllAPI() async {
    isLoading.value = true;
    update();
    await getRole();
    await getCountAssignment();
    if(role.value == "Cleaner"){
      tasksByCleaner = await getTaskByCleaner();
    }else if(role.value == "Leader"){
      location = await getLocations();
      cleaner = await getCleaners();
    }else if(role.value == "Supervisor"){
      tasksBySupervisor = await getTaskBySupervisor();
    }

    isLoading.value = false;
    update();
  }

  // Cleaner
  Future<List<AllTasksByCleanerModel>> getTaskByCleaner() async {
    final response = await TaskByCleanerService().allTaskByCleaner();
    List<AllTasksByCleanerModel> tasks = [];
    tasks = response.data != null
        ? (response.data['data'] as List)
            .map((e) => AllTasksByCleanerModel.fromJson(e))
            .toList()
        : [];
    update();
    return tasks;
  }

  //Leader
  Future<List<UserModel>> getCleaners() async {
    List<UserModel> cleaners = [];
    final response = await CleanerService().allCleaner();
    cleaners = response.data != null ?
        (response.data as List).map((e) => UserModel.fromJson(e)).toList() : [];
    update();
    return cleaners;
  }

  Future<List<LocationModel>> getLocations() async {
    final response = await LocationService().allLocation();
    List<LocationModel> locations = [];
    locations = response.data != null
        ? (response.data['data'] as List)
            .map((e) => LocationModel.fromJson(e))
            .toList()
        : [];
    update();
    return locations;
  }

  Future<List<AreaModel>> getAreas() async {
    final response = await AreaService().allArea();
    List<AreaModel> areas = [];
    areas = response.data != null
        ? (response.data['data'] as List)
            .map((e) => AreaModel.fromJson(e))
            .toList()
        : [];
    update();
    return areas;
  }

  Future<List<AreaModel>> getAreasByLocation(int id) async {
    final response = await AreaService().allAreaByLocation(id);
    List<AreaModel> areas = [];
    areas = response.data != null
        ? (response.data['data'] as List)
            .map((e) => AreaModel.fromJson(e))
            .toList()
        : [];
    update();
    return areas;
  }

  //Supervisor
  Future<List<TaskAssignmentModel>> getTaskBySupervisor() async {
    final response = await CleaningSupervisorService().getBySupervisor();
    List<TaskAssignmentModel> tasks = [];
    tasks = response.data != null
        ? (response.data['data'] as List)
            .map((e) => TaskAssignmentModel.fromJson(e))
            .toList()
        : [];
    update();
    return tasks;
  }

  // ---------------------- Widget Operation

  Widget bodyCleaning() {
    switch (role.value) {
      case 'Cleaner':
        return cleaningCleaner(this);
      case 'Leader':
        return cleaningLeader(this);
      case 'Supervisor':
        return cleaningSupervisor(this);
      case 'Danone':
        return cleaningDanone(this);
      default:
        return LoadingOverlayPro(
          isLoading: true,
          progressIndicator: loading(),
          child: const SizedBox()
        );
    }
  }

  // ---------------------- Lifecycle Operation

  @override
  void onInit() async {
    super.onInit();
    await fetchAllAPI();
  }

  @override
  void onClose() {
    super.onClose();
    task.dispose();
  }
}
