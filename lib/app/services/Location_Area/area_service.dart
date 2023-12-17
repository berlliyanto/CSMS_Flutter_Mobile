import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AreaService extends GetConnect{

  final url = "https://aplikasipms.com/api";

  String getToken()  {
    final box = GetStorage();
    String token = box.read('token');
    return token;
  }

  Future<Response> allArea() async {

    final token  = getToken();
    try {
      final response = await get("$url/areas", headers: {
        'Authorization': 'Bearer $token',
        'Accept' : 'application/json',
      });
      return response;
    } catch (e) {
      return const Response(statusCode: 401);
    }
  }

  Future<Response> allAreaByLocation(int id) async {
    final token = getToken();

    try {
      final response = await get("$url/areas_by_location/$id", headers: {
        'Authorization': 'Bearer $token',
        'Accept' : 'application/json',
      });
      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }
}