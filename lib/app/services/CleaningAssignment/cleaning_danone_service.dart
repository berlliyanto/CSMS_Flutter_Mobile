import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_assignment_service.dart';

class CleaningDanoneService extends CleaningAssignmentService {
  Future<Response> getByDanone() async {
    final token = this.token();

    try {
      final response = await dio.get(
        "$url/index_assign_danone",
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          sendTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30)
        ),
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
      checkException(error,
          error.response != null ? error.response!.data['message'] : "Error");
      return Response(requestOptions: RequestOptions());
    } catch (e) {
      return Response(requestOptions: RequestOptions());
    }
  }

  Future<Response> updateByDanone(int id) async {
    final token = this.token();
    final body = jsonEncode({"isVerified": true});
    try {
      final response = await dio
          .put(
            "$url/update_assign_danone/$id",
            data: body,
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
      checkException(error,
          error.response != null ? error.response!.data['message'] : "Error");
      return Response(statusCode: 400, requestOptions: RequestOptions());
    } catch (e) {
      return Response(statusCode: 400, requestOptions: RequestOptions());
    }
  }
}
