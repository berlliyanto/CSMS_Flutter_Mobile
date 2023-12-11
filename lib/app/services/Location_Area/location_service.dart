import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocationService extends GetConnect{

  final url = "http://192.168.100.160:8080/api";

  Future getToken() async {
    final box = GetStorage();
    String token = box.read('token');
    return token;
  }

  Future<Response> allLocation() async {

    final token  = await getToken();

    try {
      final response = await get("$url/locations", headers: {
        'Authorization': 'Bearer $token',
        'Accept' : 'application/json',
      });
      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }
}