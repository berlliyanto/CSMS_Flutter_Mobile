import 'package:flutter_mobile_csms/app/models/location_model.dart';
import 'package:flutter_mobile_csms/app/services/Location_Area/location_service.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  var isLoading = false.obs;
  List<LocationModel> locations = [];

  Future<void> getLocation() async {
    isLoading.value = true;
    update();
    final response = await LocationService().allLocation();
    if (response.statusCode == 200) {
      locations = locations = response.data != null
          ? (response.data['data'] as List)
              .map((e) => LocationModel.fromJson(e))
              .toList()
          : [];
    }
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getLocation();
  }
}
