import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TaskByCleanerService extends GetConnect {
  final url = "https://aplikasipms.com/api";

  String getToken() {
    final box = GetStorage();
    String token = box.read('token');
    return token;
  }

  Future<Response> allTaskByCleaner() async {
    final token = getToken();

    try {
      final response = await get("$url/tasks_by_cleaner", headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }

  Future<Response> showTaskByCleaner(int id, int assignId) async {
    final token = getToken();

    try {
      final response =
          await get("$url/show_tasks_by_cleaner/$id/$assignId", headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }

  Future<Response> updateStatusTask(int id, String status) async {
    final token = getToken();

    try {
      final response = await put("$url/update_status_task/$id", {
        "status": status
      }, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }

  Future<Response> updateFinishTask(FormData data, int id) async {
    final token = getToken();

    try {
      final response = await post(
        "$url/update_finish_task/$id",
        data,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }

}
