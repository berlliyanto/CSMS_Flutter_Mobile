import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/widgets/button.dart';
import 'package:flutter_mobile_csms/app/widgets/loading.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:flutter_mobile_csms/app/widgets/textfield.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<LoginController>(builder: (builder) {
      return LoadingOverlayPro(
        isLoading: builder.isLoading.value,
        progressIndicator: loading(),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  text("CLEANING SERVICE MANAGEMENT SYSTEM", 26, Colors.black87,
                      FontWeight.bold, TextAlign.center),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset('assets/images/logo_login.png',
                      width: 100, height: 100),
                  const SizedBox(
                    height: 10,
                  ),
                  text("PT. SOEKIMAN PUTRA PERKASA", 16, Colors.black87,
                      FontWeight.normal, TextAlign.center),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text("Sign In", 40, Colors.deepOrange, FontWeight.bold,
                            TextAlign.start),
                        const SizedBox(
                          height: 15,
                        ),
                        textFieldNormal(
                            "Username", controller.userNameController),
                        const SizedBox(
                          height: 15,
                        ),
                        Obx(
                          () => TextField(
                            controller: controller.passwordController,
                            obscureText: controller.obscure.value,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.deepOrange),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.deepOrange, width: 3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Password",
                              labelStyle:
                                  const TextStyle(color: Colors.deepOrange),
                              suffixIcon: IconButton(
                                  onPressed: () => controller.changeObscure(),
                                  icon: Icon(
                                    controller.obscure.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.deepOrange,
                                  )),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            text(
                                'Daftar akun cleaner disini',
                                16,
                                Colors.black87,
                                FontWeight.normal,
                                TextAlign.start),
                            TextButton(
                              onPressed: () => Get.toNamed('/register'),
                              child: text('daftar', 16, Colors.deepOrange,
                                  FontWeight.bold, TextAlign.start),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: buttonPrimary(
                            "Masuk",
                            () => controller.login(
                                controller.userNameController.text,
                                controller.passwordController.text),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      );
    }));
  }
}
