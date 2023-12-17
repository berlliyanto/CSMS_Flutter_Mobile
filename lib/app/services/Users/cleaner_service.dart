import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CleanerService extends GetConnect {
  final url = "https://aplikasipms.com/api";

  Future getToken() async {
    final box = GetStorage();
    String token = box.read('token');
    return token;
  }

  Future<Response> allCleaner() async {

    final token  = await getToken();

    try {
      final response = await get("$url/all_cleaners", headers: {
        'Authorization': 'Bearer $token',
        'Accept' : 'application/json',
      });

      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }
}