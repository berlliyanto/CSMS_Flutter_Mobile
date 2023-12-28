import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/services/error_handler.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';

class AssestmentService {
  final url = "http://192.168.100.160:8080/api";
  Dio dio = Dio();

  String getToken() {
    final box = GetStorage();
    String token = box.read('token');
    return token;
  }

  Future<Response> storeWithCleaningsTable(Map<String, dynamic> data) async {
    final token = getToken();

    try {
      final response = await dio
          .post(
            "$url/assestments",
            data: jsonEncode(data),
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
              sendTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30)
            ),
          )
          ;

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
      return Response(statusCode: 400, requestOptions: RequestOptions());
    } catch (e) {
      return Response(statusCode: 400, requestOptions: RequestOptions());
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
              sendTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30)
            ),
          )
          ;
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
      return Response(statusCode: 400, requestOptions: RequestOptions());
    } catch (e) {
      return Response(statusCode: 400, requestOptions: RequestOptions());
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
              sendTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30)
            ),
          )
          ;

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
      return Response(statusCode: 400, requestOptions: RequestOptions());
    } catch (e) {
      return Response(statusCode: 400, requestOptions: RequestOptions());
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
              sendTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30)
            ),
          )
          ;

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
      return Response(statusCode: 400, requestOptions: RequestOptions());
    } catch (e) {
      return Response(statusCode: 400, requestOptions: RequestOptions());
    }
  }

  void checkException(DioException error, String message) {
    APIException exception = APIException();
    List<String> errorMessage = exception.getExceptionMessage(error, message);

    snackBar(errorMessage[0], errorMessage[1], SnackPosition.TOP, 10,
        Colors.red, Colors.white);
  }
}
