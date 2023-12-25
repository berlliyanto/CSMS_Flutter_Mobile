import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_mobile_csms/app/services/error_handler.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileDownloadService {
  final url = "https://aplikasipms.com/api";
  Dio dio = Dio();

  void showToast(String msg) => Fluttertoast.showToast(msg: msg);

  Future<void> downloadImage(String image) async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;

    final storageStatus = android.version.sdkInt < 33
        ? await Permission.storage.request()
        : PermissionStatus.granted;
    if (storageStatus == PermissionStatus.granted) {
      Directory? directory = await getExternalStorageDirectory();
      await FlutterDownloader.enqueue(
        url: "$url/download_image/$image",
        headers: {},
        saveInPublicStorage: true,
        savedDir: directory!.path,
        showNotification: true, 
        openFileFromNotification: true, 
      );
    } else {
      showToast("Permission Denied");
    }
  }

  void checkException(DioException error, String message) {
    APIException exception = APIException();
    List<String> errorMessage = exception.getExceptionMessage(error, message);

    snackBar(errorMessage[0], errorMessage[1], SnackPosition.TOP, 10,
        Colors.red, Colors.white);
  }
}

      // if (directory != null) {
      //   String path = '${directory.path}/image-${DateTime.now()}.jpg';
      //   File file = File(path);

      //   try {
      //     final response = await dio.get(
      //       "$url/download_file/$image",
      //       options: Options(
      //         responseType: ResponseType.bytes,
      //       ),
      //     );

      //     if (response.statusCode == 200) {
      //       await file.writeAsBytes(response.data);
      //       snackBar("Sukses", "Sukses download", SnackPosition.TOP, 10, Colors.green, Colors.white);
      //     } else {
      //       throw DioException(
      //           requestOptions: RequestOptions(path: url),
      //           response: response,
      //           type: DioExceptionType.connectionError,
      //           message: response.data['message'].toString());
      //     }
      //   } catch (error) {
      //     print(error);
      //     // Tangani kesalahan
      //   }
      // } else {
      //   print("no directory");
      // }