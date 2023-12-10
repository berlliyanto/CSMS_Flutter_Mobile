import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/routes/app_pages.dart';
import 'package:flutter_mobile_csms/app/services/Auth/auth_service.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  late TextEditingController userNameController;
  late TextEditingController passwordController;

  RxBool obscure = true.obs;
  RxBool isLoading = false.obs;
  void changeObscure() {
    obscure.value = !obscure.value;
  }

  Future login(String username, String password) async {
    if (username == '' || password == '') {
      Get.snackbar('Error', 'Please fill all the fields',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    update();
    try {
      final response = await AuthService().login(username, password);
      print(response.body);
      if (response.statusCode == 200) {
        final box = GetStorage();
        box.write('token', response.body['token']);
        Get.offAllNamed(Routes.HOME);
        isLoading.value = false;
      } else {
        snackBar("Login Gagal", "Email atau password salah", SnackPosition.TOP,
            10, Colors.red.shade500.withOpacity(0.8), Colors.white);
        isLoading.value = false;
      }
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    passwordController.dispose();
  }
}
