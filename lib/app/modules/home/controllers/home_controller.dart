import 'package:flutter_mobile_csms/app/modules/home/controllers/menu_home.dart';
import 'package:flutter_mobile_csms/app/services/Auth/auth_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {

  final count = 0.obs;
  List menuHome = [].obs;
  late RxString role = ''.obs;

  RxBool isLoading = false.obs;

  Future logout() async {
    final box = GetStorage();
    String token  = box.read('token');
    isLoading.value = true;
    update();
    final response = await AuthService().logout(token);
    print(response.body);
    if(response.statusCode == 200){
      box.remove('token');
      Get.offAllNamed('/login');
    }
    isLoading.value = false;
    update();
  }

  void increment() => count.value++;

  Future getRole() async {
    final box = GetStorage();
    String token = box.read('token');
    var value = await AuthService().profile(token);
    role.value = value.body['data']['role']['role_name'];

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
      menuHome = MenuHome.menuManagement;
    }

    update();
  }


  @override
  void onInit() async {
    super.onInit();
    await getRole();
  }
}
