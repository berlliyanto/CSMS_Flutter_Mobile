import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/models/task_assignment_model.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningAssignment/widgets/form_dialog_edit.dart';
import 'package:flutter_mobile_csms/app/services/Auth/auth_service.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_danone_service.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_leader_service.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_supervisor_service.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CleaningAssignmentDetailController extends GetxController {
  final TextEditingController tasksController = TextEditingController();

  RxList tasks = [].obs;
  int argId = Get.arguments['id'];
  var isLoading = false.obs;
  var role = "".obs;
  var selectedCleaner = 0.obs;
  dynamic urlBefore = "".obs;
  dynamic urlFinish = "".obs;
  dynamic urlProgress = "".obs;
  dynamic catatan = "-".obs;
  dynamic alasan = "-".obs;
  dynamic status = "-".obs;

  Rx<TaskAssignmentModel> task = TaskAssignmentModel().obs;

  Future<TaskAssignmentModel> showTaskLeader() async {
    final response = await CleaningLeaderService().showCleaning(argId);
    TaskAssignmentModel task = response.data != null
        ? TaskAssignmentModel.fromJson(response.data['data'])
        : TaskAssignmentModel();

    return task;
  }

  Future deleteCleaning() async {
    final response = await CleaningLeaderService().deleteCleaning(argId);
    if (response.statusCode == 200) {
      Get.back();
      snackBar("Sukses", response.data['message'], SnackPosition.TOP, 10,
          Colors.green.shade500, Colors.white);
    } else {
      snackBar("Error", "Something went wrong", SnackPosition.TOP, 10,
          Colors.red.shade400, Colors.white);
    }
  }

  Future updateBySupervisor() async {
    final response =
        await CleaningSupervisorService().updateBySupervisor(argId);
    if (response.statusCode == 200) {
      Get.back();
      snackBar("Sukses", response.data['message'], SnackPosition.TOP, 10,
          Colors.green.shade500, Colors.white);
    } else {
      snackBar("Error", response.data['message'], SnackPosition.TOP, 10,
          Colors.red.shade400, Colors.white);
    }
  }

  Future updateByDanone() async {
    final response =
        await CleaningDanoneService().updateByDanone(argId);
    if (response.statusCode == 200) {
      Get.back();
      snackBar("Sukses", response.data['message'], SnackPosition.TOP, 10,
          Colors.green.shade500, Colors.white);
    } else {
      snackBar("Error", response.data['message'], SnackPosition.TOP, 10,
          Colors.red.shade400, Colors.white);
    }
  }

  Future getRole() async {
    final box = GetStorage();
    String token = box.read('token');
    var response = await AuthService().profile(token);
    role.value =
        response.data != null ? response.data['data']['role']['role_name'] : "";
    update();
  }

  Future fetchAllAPI() async {
    isLoading.value = true;
    update();
    await getRole();
    task.value = await showTaskLeader();
    isLoading.value = false;
    update();
  }

  Future updateTask() async {
    if(tasks.isEmpty){
      snackBar("Warning", "Tidak ada task yang diinput", SnackPosition.TOP, 10, const Color.fromARGB(255, 201, 181, 0), Colors.white);
      return;
    }

    final formattedTask = tasks.join("|");

    isLoading.value = true;
    update();
    final response = await CleaningLeaderService().updateTask(argId, formattedTask);
    if (response.statusCode == 200) {
      Get.back();
      snackBar("Sukses", response.data['message'], SnackPosition.TOP, 10, Colors.green.shade500, Colors.white);
    }else{
      snackBar("Error", response.data['message'], SnackPosition.TOP, 10, Colors.red.shade400, Colors.white);
    }
    isLoading.value = false;
    update();
  }

  void addTask() {
    if (tasksController.text != '') {
      tasks.add(tasksController.text);
      tasksController.clear();
    }
    update();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    update();
  }

  void openDialogEdit() {
    for (var e in (task.value.tasks ?? [])) {
      tasks.add(e);
    }
    update();

    formDialog(this, "Ubah Assignment", "", "Submit", "Batal",
    () => addTask(), 
    () => updateTask(), 
    () {
      tasks.value = [];
      update();
      Get.back();
    }, 
    () {
      tasks.value = [];
      update();
    });
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchAllAPI();
  }
}
