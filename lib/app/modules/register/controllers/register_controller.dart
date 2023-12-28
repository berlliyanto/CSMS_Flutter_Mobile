import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/services/Auth/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController emailController;

  var isLoading = false.obs;

  void showToast(String msg) => Fluttertoast.showToast(msg: msg);

  void register(
      String name, String email, String username, String password) async {
    if (name != '' || email != '' || username != '' || password != '') {
      isLoading.value = true;
      update();
      final response =
          await AuthService().register(name, email, username, password);
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Register Success',
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.toNamed('/login');
      }
    } else {
      Get.snackbar('Error', 'Please fill all the fields',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
  }
}
