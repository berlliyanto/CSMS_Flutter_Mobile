import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        useMaterial3: true,
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
