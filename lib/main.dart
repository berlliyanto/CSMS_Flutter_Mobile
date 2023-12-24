import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/utils/dependency_injection.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await FlutterDownloader.initialize(
    debug: true,
    ignoreSsl: true,
  );
  await GetStorage.init();
  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      title: "Cleaning Service Management System",
      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 600),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
