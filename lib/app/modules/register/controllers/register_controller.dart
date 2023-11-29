import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/services/Auth/auth_service.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {

  late TextEditingController nameController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController emailController;

  void register(String name, String email, String username, String password){
    if(name != '' || email != '' || username != '' || password != ''){
      AuthService().register(name, email, username, password)
      .then((value) {
        if(value.statusCode == 200){
          Get.snackbar('Success', 'Register Success', backgroundColor: Colors.green, colorText: Colors.white);
          Get.toNamed('/login');
        }else{
          Get.snackbar('Error', 'Register Failed', backgroundColor: Colors.red, colorText: Colors.white);
        }
      });
    }else{
      Get.snackbar('Error', 'Please fill all the fields', backgroundColor: Colors.red, colorText: Colors.white);
    }
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
