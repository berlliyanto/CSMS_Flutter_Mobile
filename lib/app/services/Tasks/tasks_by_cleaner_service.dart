import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/services/Tasks/tasks_service.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:dio/dio.dart';

class TaskByCleanerService extends TaskService{

  Future<Response> allTaskByCleaner() async {
    final token = getToken();

    try {
      final response = await dio
          .get("$url/tasks_by_cleaner",
              options: Options(headers: {
                'Authorization': 'Bearer $token',
                'Accept': 'application/json',
              }))
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

  Future<Response> showTaskByCleaner(int id, int assignId) async {
    final token = getToken();

    try {
      final response = await dio
          .get("$url/show_tasks_by_cleaner/$id/$assignId",
              options: Options(headers: {
                'Authorization': 'Bearer $token',
                'Accept': 'application/json',
              }))
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

  Future<Response> updateStatusTask(int id, String status) async {
    final token = getToken();

    try {
      final response = await dio
          .put("$url/update_status_task/$id",
              data: {"status": status},
              options: Options(headers: {
                'Authorization': 'Bearer $token',
                'Accept': 'application/json',
              }))
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

  Future<Response> updateFinishTask(FormData data, int id) async {
    final token = getToken();

    try {
      final response = await dio
          .post("$url/update_finish_task/$id",
              data: data,
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                  'Accept': 'application/json',
                },
                contentType: 'multipart/form-data',
              ))
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
