import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/controllers/darkmode_controller.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  SplashView({Key? key}) : super(key: key);
  final darkModeC = Get.find<DarkModeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo_login.png', width: 100, height: 100),
            const SizedBox(height: 20,),
            const Text("Cleaning Service Management System", 
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),)
          ],
        ),
      )
      
    );
  }
}
