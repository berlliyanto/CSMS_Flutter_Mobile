import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_assignment_service.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CleaningSupervisorService extends CleaningAssignmentService {
  Future<Response> getBySupervisor() async {
    final token = this.token();

    try {
      final response = await dio
          .get(
            "$url/index_assign_supervisor",
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

      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioException(
            requestOptions: RequestOptions(path: url),
            response: response,
            type: DioExceptionType.connectionError,
            message: response.data['message'].toString());
      }
    } on DioException catch (error) {
      checkException(error, error.response != null ? error.response!.data['message'] : "Error");
      return Response(statusCode: 400, requestOptions: RequestOptions(), statusMessage: "Error");
    } catch (e) {
      return Response(statusCode: 400, requestOptions: RequestOptions(), statusMessage: "Error");
    }
  }

  Future<Response> updateBySupervisor(int id) async {
    final token = this.token();
    final body = jsonEncode({"isVerified": true});

    try {
      final response = await dio
          .put(
            "$url/update_assign_supervisor/$id",
            data: body,
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

      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: url),
          response: response,
          type: DioExceptionType.connectionError,
          message: response.data['message'].toString(),
        );
      }
    } on DioException catch (error) {
      checkException(error, error.response != null ? error.response!.data['message'] : "Error");
      return Response(statusCode: 400, requestOptions: RequestOptions(), statusMessage: "Error");
    } catch (e) {
      return Response(statusCode: 400, requestOptions: RequestOptions(), statusMessage: "Error");
    }
  }

}
