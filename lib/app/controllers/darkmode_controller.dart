import 'package:get/get.dart';

class DarkModeController extends GetxController{
  RxBool isDarkMode = false.obs;

  void changeMode() => isDarkMode.value = !isDarkMode.value;

}