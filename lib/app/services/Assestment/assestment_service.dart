import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AssestmentService extends GetConnect {
  final url = "http://192.168.100.160:8080/api";

  String getToken() {
    final box = GetStorage();
    String token = box.read('token');
    return token;
  }

  Future<Response> storeWithCleaningsTable(Map<String, dynamic> data) async {
    final token = getToken();

    try {
      final response = post("$url/assestments", jsonEncode(data), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }

  Future<Response> getAssestmentPerCleaner(int id) async {
    final token = getToken();
    try {
      final response =
          await get("$url/calculate_assestment_cleaner/$id", headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      return response;
    } catch (e) {
      return Response(statusCode: 404, statusText: e.toString());
    }
  }
}
