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
    '"Belajarlah dari pengalaman generasi sebelum kalian. Bersungguh - sungguhlah dan jangan melupakan agar kalian tidak dilupakan." - Utsman bin Affan',
    '"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work." - Steve Jobs',
    '"Orang yang suka berkata jujur mendapatkan tiga hal: kepercayaan, cinta dan rasa hormat." - Ali bin Abi Thalib',
    '"The only limit to our realization of tomorrow will be our doubts of today." - Franklin D. Roosevelt',
    '"Believe you can and you are halfway there." - Theodore Roosevelt',
    '"The future belongs to those who believe in the beauty of their dreams." - Eleanor Roosevelt',
    '"Hard work beats talent when talent does not work hard." - Tim Notke',
    '"Dont watch the clock; do what it does. Keep going." - Sam Levenson',
    '"The only place where success comes before work is in the dictionary." - Vidal Sassoon',
    '"Kerja keras adalah kunci sukses yang paling sering terlupakan." - Thomas A. Edison',
    '"Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful." - Albert Schweitzer',
    '"Im a greater believer in luck, and I find the harder I work the more I have of it." - Thomas Jefferson',
    '"Kegigihan adalah kunci utama kesuksesan." - Charles Chaplin',
    '"Tantangan terbesar dalam hidup adalah menemukan siapa diri kita sejati dan melakukan yang terbaik." - Mehnaz Ansari',
    '"Kerja keras membawa hasil, tetapi percaya pada diri sendiri membawa keberuntungan." - Thomas Jefferson',
    '"Kesuksesan bukanlah kunci kebahagiaan. Kebahagiaanlah kunci kesuksesan." - Albert Schweitzer',
    '"Set your goals high, and dont stop till you get there." - Bo Jackson',
    '"Kesuksesan adalah hasil dari kerja keras, pembelajaran dari kegagalan, ketekunan, dan dedikasi untuk mencapai tujuan yang diinginkan." - Frank Lloyd Wright',
    '"Ialah hal yang memalukan bahwa seekor burung justru bangun lebih awal daripada kamu di pagi hari." - Abu Bakar Ash-Shiddiq',
    '"Your talent determines what you can do. Your motivation determines how much you are willing to do. Your attitude determines how well you do it." - Lou Holtz',
    '"Bekerja keras hari ini adalah investasi untuk hari esok yang lebih baik." - Unknown',
    '"Jadikan kegagalanmu sebagai tonggak kesuksesan yang akan datang." - Unknown',
    '"Jadikan kehidupan dunia sebagai kunci kesuksesan untuk kehidupan Akhirat." - Unknown',
    '"Jangan jadikan hidup ini sebagai beban, berserah dirilah kepada Tuhan yang maha esa." - Unknown',
    '"Tetap rendah hati dan bersyukur." - Unknown',
    '"Tetap semangat dan bersabar untuk menantikan kehidupan yang lebih baik" - Unknown',
    '"Success is the sum of small efforts, repeated day in and day out." - Robert Collier',
    '"Dont count the days, make the days count." - Muhammad Ali',
    '"Jangan berlebihan dalam mencintai sehingga menjadi keterikatan, jangan pula berlebihan dalam membenci sehingga membawa kebinasaan." - Umar Bin Khattab',
    '"Bersikaplah baik, karena setiap kali kebaikan menjadi bagian dari sesuatu, itu memperindahnya. Setiap kali itu diambil dari sesuatu, itu membuatnya ternoda." - Muhammad SAW'
  ];

  List menuHome = [].obs;
  late RxString role = ''.obs;

  RxBool isLoading = false.obs;
  RxString greeting = ''.obs;
  RxString name = ''.obs;
  RxString quote = ''.obs;

  void changeQuote() {
    final random = Random();
    Timer.periodic(const Duration(seconds: 20), (timer) {
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
