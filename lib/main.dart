import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/controllers/darkmode_controller.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final darkmodeC = Get.put(DarkModeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      title: "Cleaning Service Management System",
      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 800),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
