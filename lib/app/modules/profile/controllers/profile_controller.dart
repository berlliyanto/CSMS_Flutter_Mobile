import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobile_csms/app/models/user_model.dart';
import 'package:flutter_mobile_csms/app/services/Auth/auth_service.dart';
import 'package:flutter_mobile_csms/app/widgets/dialog.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();

  ProfileUserModel profile = ProfileUserModel(
    id: 0,
    name: '',
    email: '',
    username: '',
    role: RoleModel(id: 0, roleName: ''),
  );

  RxBool isObscure1 = true.obs;
  RxBool isObscure2 = true.obs;
  RxBool isLoading = false.obs;

  void changeObscure(int pw) {
    if(pw == 1){
      isObscure1.value = !isObscure1.value;
    }else if(pw == 2){
      isObscure2.value = !isObscure2.value;
    }
  }

  Future logout() async {
    final box = GetStorage();
    String token = box.read('token');
    isLoading.value = true;
    update();
    final response = await AuthService().logout(token);
    if (response.statusCode == 200) {
      box.remove('token');
      Get.offAllNamed('/login');
    }else{
      Get.offAllNamed('/login');
    }
    isLoading.value = false;
    update();
  }

  Future updatePassword() async {
    if(password1.text == "" || password2.text == ""){
      snackBar("Error", "Password tidak boleh kosong", SnackPosition.TOP, 10, Colors.red, Colors.white);
      return;
    }

    if(password1.text != password2.text){
      snackBar("Error", "Password tidak sama", SnackPosition.TOP, 10, Colors.red, Colors.white);
      return;
    }

    final box = GetStorage();
    String token = box.read('token');
    final response = await AuthService().updatePassword(token, password2.text);
    if (response.statusCode == 200) {
      snackBar("Sukses", response.data['message'], SnackPosition.TOP, 10, Colors.green.shade500, Colors.white);
      dialog("Password telah diubah", "Apakah anda ingin login ulang?", "Ya", "Tidak", () => logout());
    }
  }


  Future getProfile() async {
    final box = GetStorage();
    String token = box.read('token');
    isLoading.value = true;
    update();
    final response = await AuthService().profile(token);
    if (response.statusCode == 200) {
      profile = ProfileUserModel.fromJson(response.data['data']);
    }
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }
}
