import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_mobile_csms/app/services/File/file_download.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FileController extends GetxController {
  final ReceivePort _port = ReceivePort();

  Future<void> downloadImage(String image) async {
    await FileDownloadService().downloadImage(
      image,
    );
    showToast("Download Running");
  }

  Future<void> downloadExcel(String path) async {
    await FileDownloadService().downloadExcel(path);
    showToast("Download Running");
  }

  void showToast(String msg) => Fluttertoast.showToast(msg: msg);


  void sendUpdate(String id, DownloadTaskStatus downloadStatus, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader');

    try {
      send?.send([id, downloadStatus, progress]);
    } catch (e) {}
  }

  @override
  void onInit() {
    super.onInit();

    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader');
    _port.listen((dynamic data) {
      DownloadTaskStatus status = data[1];
      if (status == DownloadTaskStatus.complete) {
        showToast("Download Complete");
      }
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    DownloadTaskStatus downloadStatus;

    switch (status) {
      case 0:
        downloadStatus = DownloadTaskStatus.undefined;
        break;
      case 1:
        downloadStatus = DownloadTaskStatus.enqueued;
        break;
      case 2:
        downloadStatus = DownloadTaskStatus.running;
        break;
      case 3:
        downloadStatus = DownloadTaskStatus.complete;
        break;
      default:
        downloadStatus = DownloadTaskStatus.failed;
    }

    FileController().sendUpdate(id, downloadStatus, progress);
  }
}
