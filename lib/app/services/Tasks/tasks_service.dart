import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/services/error_handler.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_storage/get_storage.dart';

class TaskService {
  final url = "http://192.168.1.12:8080/api";
  Dio dio = Dio();

  String getToken() {
    final box = GetStorage();
    String token = box.read('token');
    return token;
  }

  Future<Response> getAllTasks(int page) async {
    final String token = getToken();

    try {
      final response = await dio
          .get(
            "$url/tasks?page=$page",
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
                'Accept': 'application/json',
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
