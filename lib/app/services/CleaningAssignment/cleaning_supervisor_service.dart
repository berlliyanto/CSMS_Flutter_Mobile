import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CleaningSupervisorService extends GetConnect {

  final url = "http://192.168.100.160:8080/api";

  String getToken() {
    final box = GetStorage();
    String token = box.read('token');
    return token;
  }

  Future<Response> getBySupervisor() async {

    final token = getToken();

    try {
      final response = await get("$url/index_by_supervisor", headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }

  Future<Response> updateBySupervisor(int id) async {

    final token = getToken();
    try {
      final response = await put(
        "$url/update_by_supervisor/$id",
        {
          "isVerified": true
        },
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