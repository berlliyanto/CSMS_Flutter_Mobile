import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TaskService extends GetConnect {
  final url = "https://aplikasipms.com/api";

  String getToken(){
    final box = GetStorage();
    String token = box.read('token');
    return token;
  }

  Future<Response> getAllTasks(int page) async {
    final String token = getToken();

    try {
      final response = await get("$url/tasks?page=$page", headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }
}