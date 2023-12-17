import 'dart:convert';

import 'package:get/get.dart';

class AuthService extends GetConnect {
  final url = "https://aplikasipms.com/api";

  Future<Response> login(String username, String password) async {
    try {
      final response = await post(
          "$url/login",
          jsonEncode(
            {"username": username, "password": password},
          ),
          headers: {
            'Accept': 'application/json',
          });
      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }

  Future<Response> logout(String token) async {
    try {
      return await get(
        "$url/logout",
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
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
      final response = await post("$url/register", body,
          headers: <String, String>{'Accept': 'application/json'});
      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }

  Future<Response> profile(String token) async {
    try {
      final response = await get(
        "$url/profile",
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }

  Future<Response> updatePassword(String token, String password) async {
    final body = jsonEncode({"password": password});
    try {
      final response = await put("$url/update_password", body, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      return response;
    } catch (e) {
      return Response(statusCode: 401, statusText: e.toString());
    }
  }
}
