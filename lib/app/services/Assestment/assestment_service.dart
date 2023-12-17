import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AssestmentService extends GetConnect {
  final url = "https://aplikasipms.com/api";

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

  Future<Response> getCalculateAssestments() async {
    final token = getToken();
    try {
      final response = await get("$url/calculate_assestment", headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      return response;
    } catch (e) {
      return Response(statusCode: 404, statusText: e.toString());
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

  Future<Response> getAssestmentFilterByDate(String type, String startDate, String endDate) async {
     final token = getToken();

    try {
      final response = await get("$url/assestment_filter_date?type=$type&start_date=$startDate&end_date=$endDate", headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }
}
