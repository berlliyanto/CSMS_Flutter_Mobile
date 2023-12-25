import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/routes/app_pages.dart';
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
  return GestureDetector(
    onTap: (){
      if(urlImage == null) return;
      Get.toNamed(Routes.ZOOM_IMAGE, arguments: urlImage);
    },
    child: Center(
      child: FutureBuilder(
          future: GetConnect()
              .get("https://aplikasipms.com/api/images/$urlImage"),
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
              return Hero(
                tag: urlImage,
                child: Container(
                  width: Get.width * 0.8,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://aplikasipms.com/api/images/$urlImage"),
                        fit: BoxFit.cover),
                  ),
                ),
              );
            }
          }),
    ),
  );
}
