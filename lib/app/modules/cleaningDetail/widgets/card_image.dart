import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget cardImageCamera(File file, String title) {
  return Center(
    child: Container(
      width: Get.width * 0.8,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: FileImage(file), fit: BoxFit.fill),
      ),
    ),
  );
}

Widget cardImageAPI(dynamic urlImage) {
  return Center(
    child: FutureBuilder(
        future: GetConnect()
            .get("https://aplikasipms.com:800/api/images/$urlImage"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                width: Get.width * 0.8,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError ||
              snapshot.data == null ||
              snapshot.error == "404" ||
              urlImage == "" ||
              urlImage == null) {
            return Container(
              width: Get.width * 0.8,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: AssetImage("assets/images/no_image.jpg"),
                    fit: BoxFit.cover),
              ),
            );
          } else {
            return Container(
              width: Get.width * 0.8,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://aplikasipms.com:800/api/images/$urlImage"),
                    fit: BoxFit.cover),
              ),
            );
          }
        }),
  );
}
