import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/models/area_model.dart';
import 'package:flutter_mobile_csms/app/models/location_model.dart';
import 'package:flutter_mobile_csms/app/models/task_by_cleaner_model.dart';
import 'package:flutter_mobile_csms/app/models/user_model.dart';
import 'package:flutter_mobile_csms/app/modules/cleaning/controllers/role_controller/cleaning_cleaner_controller.dart';
import 'package:flutter_mobile_csms/app/modules/cleaning/controllers/role_controller/cleaning_leader_controller.dart';
import 'package:flutter_mobile_csms/app/modules/cleaning/views/role_view/cleaning_cleaner.dart';
import 'package:flutter_mobile_csms/app/modules/cleaning/views/role_view/cleaning_leader.dart';
import 'package:flutter_mobile_csms/app/services/Auth/auth_service.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_leader_service.dart';
import 'package:flutter_mobile_csms/app/widgets/loading.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

class CleaningController extends GetxController {
  final CleaningCleanerController cleaningCleanerController = Get.put(CleaningCleanerController());
  final CleaningLeaderController cleaningLeaderController = Get.put(CleaningLeaderController());
  TextEditingController task = TextEditingController();

  List<UserModel> cleaner = [];
  List<LocationModel> location = [];
  List<AreaModel> area = [];
  List<AllTasksByCleanerModel> tasksByCleaner = [];

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
    role.value = value.body != null ? value.body['data']['role']['role_name'] : '';
    update();
  }

  Future fetchAllAPI() async {
    if(role.value == "Cleaner"){
      tasksByCleaner = await cleaningCleanerController.getTaskByCleaner();
    }else if(role.value == "Leader"){
      location = await cleaningLeaderController.getLocations();
      cleaner = await cleaningLeaderController.getCleaners();
    }

    update();
  }

  // ---------------------- Widget Operation

  Widget bodyCleaning() {
    switch (role.value) {
      case 'Cleaner':
        return cleaningCleaner(this);
      case 'Leader':
        return cleaningLeader(this);
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
    await getRole();
    await fetchAllAPI();
  }

  @override
  void onClose() {
    super.onClose();
    task.dispose();
  }
}
