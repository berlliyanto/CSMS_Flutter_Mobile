import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_assignment_service.dart';
import 'package:get/get.dart';

class CleaningLeaderService extends CleaningAssignmentService {

  Future<Response> postCleaning(Map<String, dynamic> data) async {
    final token = this.token();

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      final response = await post("$url/assign_task", data, headers: header);
      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }

  Future<Response> getCleaning() async {
    final String token = this.token();

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      final response = await get("$url/index_assign_leader", headers: header);
      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }

  Future<Response> showCleaning(int id) async {
    final String token = this.token();

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      final response = await get("$url/assign/$id", headers: header);
      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }

  Future<Response> updateTask(int id, String task) async {
    final String token = this.token();
    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
    try {
      final response = await put("$url/update_assign_task/$id", 
      {
        "task": task,
      }, 
      headers: header);

      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }

  Future<Response> deleteCleaning(int id) async {
    final String token = this.token();
    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      final response =
          await delete("$url/delete_assign_with_tasks/$id", headers: header);
      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }
}
