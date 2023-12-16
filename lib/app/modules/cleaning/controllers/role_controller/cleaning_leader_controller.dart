import 'package:flutter_mobile_csms/app/models/area_model.dart';
import 'package:flutter_mobile_csms/app/models/location_model.dart';
import 'package:flutter_mobile_csms/app/models/user_model.dart';
import 'package:flutter_mobile_csms/app/services/Location_Area/area_service.dart';
import 'package:flutter_mobile_csms/app/services/Location_Area/location_service.dart';
import 'package:flutter_mobile_csms/app/services/Users/cleaner_service.dart';
import 'package:get/get.dart';

class CleaningLeaderController extends GetxController {
  Future<List<UserModel>> getCleaners() async {
    List<UserModel> cleaners = [];
    final response = await CleanerService().allCleaner();
    cleaners = response.body != null ?
        (response.body as List).map((e) => UserModel.fromJson(e)).toList() : [];
    update();
    return cleaners;
  }

  Future<List<LocationModel>> getLocations() async {
    final response = await LocationService().allLocation();
    List<LocationModel> locations = [];
    locations = response.body != null
        ? (response.body['data'] as List)
            .map((e) => LocationModel.fromJson(e))
            .toList()
        : [];
    update();
    return locations;
  }

  Future<List<AreaModel>> getAreas() async {
    final response = await AreaService().allArea();
    List<AreaModel> areas = [];
    areas = response.body != null
        ? (response.body['data'] as List)
            .map((e) => AreaModel.fromJson(e))
            .toList()
        : [];
    update();
    return areas;
  }

  Future<List<AreaModel>> getAreasByLocation(int id) async {
    final response = await AreaService().allAreaByLocation(id);
    List<AreaModel> areas = [];
    areas = response.body != null
        ? (response.body['data'] as List)
            .map((e) => AreaModel.fromJson(e))
            .toList()
        : [];
    update();
    return areas;
  }
}