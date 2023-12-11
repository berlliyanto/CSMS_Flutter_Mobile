import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CleaningLeaderService extends GetConnect {
  final url = "http://192.168.100.160:8080/api";

  String token() {
    final box = GetStorage();
    String token = box.read('token');
    return token;
  }

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
      final response = await get("$url/assigns_by_leader", headers: header);
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

  // Future<Response> updateCleaning(int id) async {}

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
