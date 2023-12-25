import 'dart:async';
import 'dart:math';

import 'package:flutter_mobile_csms/app/modules/home/controllers/menu_home.dart';
import 'package:flutter_mobile_csms/app/routes/app_pages.dart';
import 'package:flutter_mobile_csms/app/services/Auth/auth_service.dart';
import 'package:flutter_mobile_csms/app/widgets/dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {

  final List<String> qouteOfTheDay = [
    '"Success is not final, failure is not fatal: It is the courage to continue that counts." - Winston Churchill',
    '"The only way to do great work is to love what you do." - Steve Jobs',
    '"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work." - Steve Jobs',
    '"Success is walking from failure to failure with no loss of enthusiasm." - Winston Churchill',
    '"The only limit to our realization of tomorrow will be our doubts of today." - Franklin D. Roosevelt',
    '"Believe you can and you are halfway there." - Theodore Roosevelt',
    '"The future belongs to those who believe in the beauty of their dreams." - Eleanor Roosevelt',
    '"Hard work beats talent when talent does not work hard." - Tim Notke',
    '"Dont watch the clock; do what it does. Keep going." - Sam Levenson',
    '"The only place where success comes before work is in the dictionary." - Vidal Sassoon'
  ];

  List menuHome = [].obs;
  late RxString role = ''.obs;

  RxBool isLoading = false.obs;
  RxString greeting = ''.obs;
  RxString name = ''.obs;
  RxString quote = ''.obs;

  void changeQuote() {
    final random = Random();
    Timer.periodic(const Duration(seconds: 30), (timer) {
      quote.value = qouteOfTheDay[random.nextInt(qouteOfTheDay.length)];
    });
  }

  void getDayTime() {
  DateTime now = DateTime.now();
  int currentHour = now.hour;
  if (currentHour >= 5 && currentHour < 12) {
    greeting.value = "Selamat Pagi";
  } else if (currentHour >= 12 && currentHour < 16) {
    greeting.value = "Selamat Siang";
  } else if (currentHour >= 16 && currentHour < 18) {
    greeting.value = "Selamat Sore";
  } else {
    greeting.value = "Selamat Malam";
  }
}

  Future getRole() async {
    isLoading.value = true;
    update();

    final box = GetStorage();
    String token = box.read('token');
    var value = await AuthService().profile(token);
    name.value = value.data != null ? value.data['data']['name'] : "User";
    role.value = value.data != null ? value.data['data']['role']['role_name'] : "relog";

    if(role.value == 'Cleaner'){
      menuHome = MenuHome.menuCleaner;
    }else if(role.value == 'Management'){
      menuHome = MenuHome.menuManagement;
    }else if(role.value == 'Leader'){
      menuHome = MenuHome.menuLeader;
    }else if(role.value == 'Supervisor'){
      menuHome = MenuHome.menuSupervisor;
    }else if(role.value == 'Danone'){
      menuHome = MenuHome.menuDanone;
    }else{
      dialog("Terjadi masalah", "Silahkan login kembali", "OK", "", () => Get.offAllNamed(Routes.LOGIN));
    }

    isLoading.value = false;
    update();
  }


  @override
  void onInit() async {
    super.onInit();
    final random = Random();
    quote.value = qouteOfTheDay[random.nextInt(qouteOfTheDay.length)];
    changeQuote();
    getDayTime();
    await getRole();
  }
}
