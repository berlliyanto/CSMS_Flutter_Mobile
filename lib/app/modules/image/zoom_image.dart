import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenImagePage extends GetView {

  const FullScreenImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic imageUrl = Get.arguments;
    return Scaffold(
      backgroundColor:Colors.black87,
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          boundaryMargin: const EdgeInsets.all(20.0),
          minScale: 0.5,
          maxScale: 2.5,
          child: Hero(
            tag: imageUrl,
            child: Image.network(
              "http://192.168.100.160:8080/api/images/$imageUrl",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}