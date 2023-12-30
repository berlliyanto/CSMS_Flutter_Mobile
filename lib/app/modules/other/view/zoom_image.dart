import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/other/controllers/file_controller.dart';
import 'package:get/get.dart';

class FullScreenImagePage extends StatelessWidget {
  FullScreenImagePage({super.key});

  final controller = Get.find<FileController>();

  @override
  Widget build(BuildContext context) {
    final dynamic imageUrl = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        children: [
          InteractiveViewer(
            panEnabled: true,
            boundaryMargin: const EdgeInsets.all(20.0),
            minScale: 0.5,
            maxScale: 2.5,
            child: SizedBox(
              height: double.infinity,
              width: Get.width,
              child: Hero(
                tag: imageUrl,
                child: Image.network(
                  "http://192.168.1.12:8080/api/images/$imageUrl",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(top: 30),
            child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 30,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () => controller.downloadImage(imageUrl),
                    icon: const Icon(
                      Icons.file_download_outlined,
                      color: Colors.white,
                      size: 30,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
