import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/models/location_model.dart';
import 'package:flutter_mobile_csms/app/models/user_model.dart';
import 'package:flutter_mobile_csms/app/services/Assestment/assestment_service.dart';
import 'package:flutter_mobile_csms/app/services/Location_Area/location_service.dart';
import 'package:flutter_mobile_csms/app/services/Users/cleaner_service.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get.dart';

class AssestmentController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt idLoc = 0.obs;
  RxInt idCleaner = 0.obs;
  Map<String, dynamic> assestData = {};
  List<UserModel> cleaner = [];
  List<LocationModel> location = [];

  Future<List<LocationModel>> getLocations() async {
    final response = await LocationService().allLocation();
    List<LocationModel> locations = [];
    locations = response.data != null
        ? (response.data['data'] as List)
            .map((e) => LocationModel.fromJson(e))
            .toList()
        : [];
    location = locations;
    update();
    return locations;
  }

  Future<List<UserModel>> getCleaners() async {
    final response = await CleanerService().allCleaner();
    List<UserModel> cleaners = [];
    cleaners = response.data != null
        ? (response.data as List).map((e) => UserModel.fromJson(e)).toList()
        : [];
    cleaner = cleaners;
    print(cleaner);
    update();
    return cleaners;
  }

  Future postDataAssestment() async {
    final response = await AssestmentService().storeWithCleaningsTable(assestData);
    if (response.statusCode == 200) {
      Get.back();
      snackBar("Sukses", "Berhasil simpan data", SnackPosition.TOP, 10,
          Colors.green.shade500, Colors.white);
    } else {
      snackBar("Error", "Something went wrong", SnackPosition.TOP, 10,
          Colors.red.shade500, Colors.white);
    }
  }

  void fetchAllAPI() async {
    isLoading.value = true;
    update();
    await getCleaners();
    await getLocations();
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllAPI();
  }

  @override
  void dispose() {
    super.dispose();
    idCleaner.value = 0;
    idLoc.value = 0;
  }
}
