import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_assignment_service.dart';
import 'package:get/get.dart';

class CleaningSupervisorService extends CleaningAssignmentService {


  Future<Response> getBySupervisor() async {

    final token = this.token();

    try {
      final response = await get("$url/index_assign_supervisor", headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }

  Future<Response> updateBySupervisor(int id) async {

    final token = this.token();
    try {
      final response = await put(
        "$url/update_assign_supervisor/$id",
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