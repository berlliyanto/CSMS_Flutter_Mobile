import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';

class CleaningAssignmentService {
  final url = "https://aplikasipms.com/api";
  Dio dio = Dio();

  String token() {
    final box = GetStorage();
    String token = box.read('token');
    return token;
  }

  Future<Response> getAllAssignment() async {
    final token = this.token();

    try {
      final response = await dio
          .get(
            "$url/assigns",
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
                'Accept': 'application/json',
              },
            ),
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () => snackBar("Error", "Connection Timeout",
                SnackPosition.TOP, 10, Colors.red, Colors.white),
          );
      return response;
    } catch (e) {
      return Response(statusCode: 401, requestOptions: RequestOptions());
    }
  }

  Future<Response> getCountAssignment() async {
    final token = this.token();

    try {
      final response = await dio
          .get(
            "$url/assign_count",
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
                'Accept': 'application/json',
              },
            ),
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () => snackBar("Error", "Connection Timeout",
                SnackPosition.TOP, 10, Colors.red, Colors.white),
          );
      return response;
    } catch (e) {
      return Response(statusCode: 401, requestOptions: RequestOptions());
    }
  }

  Future<Response> getAssignmentFilterDate(
      String type, String startDate, String endDate) async {
    final token = this.token();

    try {
      final response = await dio
          .get(
            "$url/assign_filter_date?type=$type&start_date=$startDate&end_date=$endDate",
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
                'Accept': 'application/json',
              },
            ),
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () => snackBar("Error", "Connection Timeout",
                SnackPosition.TOP, 10, Colors.red, Colors.white),
          );

      return response;
    } catch (e) {
      return Response(statusCode: 401, requestOptions: RequestOptions());
    }
  }
}
