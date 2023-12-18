import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_storage/get_storage.dart';

class CleanerService {
  final url = "https://aplikasipms.com/api";
  Dio dio = Dio();

  Future getToken() async {
    final box = GetStorage();
    String token = box.read('token');
    return token;
  }

  Future<Response> allCleaner() async {
    final token = await getToken();

    try {
      final response = await dio
          .get(
            "$url/all_cleaners",
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
