import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_assignment_service.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class CleaningDanoneService extends CleaningAssignmentService {

  Future<Response> updateByDanone(int id) async {
    final token = this.token();
    final body = jsonEncode({"isVerified": true});
    try {
      final response = await dio.put(
        "$url/update_assign_danone/$id",
        data: body,
        options: Options(
              headers: {
                'Authorization': 'Bearer $token',
                'Accept': 'application/json',
              },
            ),
      ).timeout(
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
