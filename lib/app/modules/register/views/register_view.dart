import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/widgets/button.dart';
import 'package:flutter_mobile_csms/app/widgets/loading.dart';
import 'package:flutter_mobile_csms/app/widgets/textfield.dart';

import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Daftar akun cleaner'),
          centerTitle: true,
        ),
        body: GetBuilder<RegisterController>(
          builder: (builder) {
            return LoadingOverlayPro(
              isLoading: builder.isLoading.value,
              progressIndicator: loading(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Image.asset('assets/images/logo_login.png',
                          width: 100, height: 100),
                      const SizedBox(
                        height: 40,
                      ),
                      textFieldNormal("Nama", builder.nameController),
                      const SizedBox(
                        height: 10,
                      ),
                      textFieldNormal("Email", builder.emailController),
                      const SizedBox(
                        height: 10,
                      ),
                      textFieldNormal("Username", builder.usernameController),
                      const SizedBox(
                        height: 10,
                      ),
                      textFieldNormal("Password", builder.passwordController),
                      const SizedBox(
                        height: 20,
                      ),
                      buttonPrimary(
                        "Daftar",
                        () => builder.register(
                            builder.nameController.text,
                            builder.usernameController.text,
                            builder.passwordController.text,
                            builder.emailController.text),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        ));
  }
}
