import 'package:dio/dio.dart';

class APIException {
  List<String> getExceptionMessage(DioException exception, String message) {
    switch (exception.type) {
      case DioExceptionType.badResponse:
        return ["Bad response error", message];

      case DioExceptionType.connectionError:
        return ["Connection error", message];

      case DioExceptionType.connectionTimeout:
        return ["Connection timeout", message];

      case DioExceptionType.unknown:
        return ["Something went wrong", message];

      case DioExceptionType.cancel:
        return ["Request cancelled", message];

      case DioExceptionType.receiveTimeout:
        return ["Receive timeout", message ];

      case DioExceptionType.sendTimeout:
        return ["Send timeout", message];

      default:
        return ["Unknown error", message];
    }
  }
}
