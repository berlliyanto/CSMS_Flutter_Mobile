import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class AuthService {
  final url = "https://aplikasipms.com/api";
  Dio dio = Dio();

  Future<Response> login(String username, String password) async {
    try {
      final response = await dio
          .post(
            "$url/login",
            data: jsonEncode(
              {"username": username, "password": password},
            ),
            options: Options(
              headers: {
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

  Future<Response> logout(String token) async {
    try {
      return await dio
          .get(
            "$url/logout",
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
    } catch (e) {
      return Response(statusCode: 401, requestOptions: RequestOptions());
    }
  }

  Future<Response> register(
      String name, String username, String password, String email) async {
    final body = jsonEncode({
      "name": name,
      "username": username,
      "email": email,
      "password": password,
    });

    try {
      final response = await dio
          .post(
            "$url/register",
            data: body,
            options: Options(headers: {'Accept': 'application/json'}),
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

  Future<Response> profile(String token) async {
    try {
      final response = await dio
          .get(
            "$url/profile",
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

  Future<Response> updatePassword(String token, String password) async {
    final body = jsonEncode({"password": password});
    try {
      final response = await dio
          .put(
            "$url/update_password",
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
      return response;
    } catch (e) {
      return Response(statusCode: 401, requestOptions: RequestOptions());
    }
  }
}
