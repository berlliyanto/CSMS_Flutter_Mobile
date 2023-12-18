import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';

class AssestmentService {
  final url = "https://aplikasipms.com/api";
  Dio dio = Dio();

  String getToken() {
    final box = GetStorage();
    String token = box.read('token');
    return token;
  }

  Future<Response> storeWithCleaningsTable(Map<String, dynamic> data) async {
    final token = getToken();

    try {
      final response = dio
          .post(
            "$url/assestments",
            data: jsonEncode(data),
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
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

  Future<Response> getCalculateAssestments() async {
    final token = getToken();
    try {
      final response = await dio
          .get(
            "$url/calculate_assestment",
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
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
      return Response(statusCode: 404, requestOptions: RequestOptions());
    }
  }

  Future<Response> getAssestmentPerCleaner(int id) async {
    final token = getToken();
    try {
      final response = await dio
          .get(
            "$url/calculate_assestment_cleaner/$id",
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
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
      return Response(statusCode: 404, requestOptions: RequestOptions());
    }
  }

  Future<Response> getAssestmentFilterByDate(
      String type, String startDate, String endDate) async {
    final token = getToken();

    try {
      final response = await dio
          .get(
            "$url/assestment_filter_date?type=$type&start_date=$startDate&end_date=$endDate",
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
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
