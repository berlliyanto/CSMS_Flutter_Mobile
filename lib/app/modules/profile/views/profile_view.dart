import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/profile/widgets/card_profile.dart';
import 'package:flutter_mobile_csms/app/modules/profile/widgets/change_password.dart';
import 'package:flutter_mobile_csms/app/widgets/button.dart';
import 'package:flutter_mobile_csms/app/widgets/loading.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: ()async {
            controller.getProfile();
          }, icon: const Icon(Icons.refresh))
        ],
      ),
      body: GetBuilder<ProfileController>(
        builder: (builder) {
          return LoadingOverlayPro(
            isLoading: builder.isLoading.value,
            progressIndicator: loading(),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text("Data Akun Anda", 18, Colors.black87, FontWeight.bold, TextAlign.start),
                    const Gap(10),
                    cardProfile(builder),
                    const Gap(10),
                    text("Ganti Password", 18, Colors.black87, FontWeight.bold, TextAlign.start),
                    const Gap(10),
                    changePassword(builder),
                    const Gap(20),
                    customButton("Logout", Colors.red, 5, 10, () => builder.logout())
                  ]
                )
              )
            ),
          );
        }
      )
    );
  }
}
