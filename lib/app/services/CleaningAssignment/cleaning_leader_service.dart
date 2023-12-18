import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_assignment_service.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class CleaningLeaderService extends CleaningAssignmentService {
  Future<Response> postCleaning(Map<String, dynamic> data) async {
    final token = this.token();

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      final response = await dio
          .post(
            "$url/assign_task",
            data: data,
            options: Options(
              headers: header,
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

  Future<Response> getCleaning() async {
    final String token = this.token();

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      final response = await dio
          .get(
            "$url/index_assign_leader",
            options: Options(
              headers: header,
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

  Future<Response> showCleaning(int id) async {
    final String token = this.token();

    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      final response = await dio
          .get(
            "$url/assign/$id",
            options: Options(headers: header),
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

  Future<Response> updateTask(int id, String task) async {
    final String token = this.token();
    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
    final body = jsonEncode({"task": task});
    try {
      final response = await dio
          .put(
            "$url/update_assign_task/$id",
            data: body,
            options: Options(
              headers: header,
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

  Future<Response> deleteCleaning(int id) async {
    final String token = this.token();
    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      final response = await dio
          .delete(
            "$url/delete_assign_with_tasks/$id",
            options: Options(headers: header),
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
