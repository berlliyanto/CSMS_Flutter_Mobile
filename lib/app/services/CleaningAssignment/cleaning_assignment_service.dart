import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CleaningAssignmentService extends GetConnect{
  final url = "https://aplikasipms.com/api";

  String token() {
    final box = GetStorage();
    String token = box.read('token');
    return token;
  }

  Future<Response> getAllAssignment() async {
    final token = this.token();

    try {
      final response = await get("$url/assigns", headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      return response;
    } catch(e){
      return Response(statusCode: 401, statusText: e.toString());
    }
  }

  Future<Response> getCountAssignment()async {
    final token = this.token();

    try {
      final response = await get("$url/assign_count", headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      return response;
    } catch(e){
      return Response(statusCode: 401, statusText: e.toString());
    }
  }

  Future<Response> getAssignmentFilterDate(String type, String startDate, String endDate) async {
    final token = this.token();

    try {
      final response = await get("$url/assign_filter_date?type=$type&start_date=$startDate&end_date=$endDate", headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }
}