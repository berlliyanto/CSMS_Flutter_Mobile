import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/userVerification/widgets/card_assign_danone.dart';
import 'package:flutter_mobile_csms/app/routes/app_pages.dart';
import 'package:flutter_mobile_csms/app/widgets/card.dart';
import 'package:flutter_mobile_csms/app/widgets/loading.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

import '../controllers/user_verification_controller.dart';

class UserVerificationView extends GetView<UserVerificationController> {
  const UserVerificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await controller.fetchAllAPI();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: GetBuilder<UserVerificationController>(
        builder: (builder) {
          final finishAssign =
              builder.assignByDanone.where((element) => element.status == true);
          return RefreshIndicator(
            onRefresh: () async {
              print("res");
            },
            child: LoadingOverlayPro(
              isLoading: builder.isLoading.value,
              progressIndicator: loading(),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text("User Verification", 24, Colors.black87,
                          FontWeight.bold, TextAlign.start),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          text("Total : ${builder.countAssign.total}", 14,
                              Colors.grey, FontWeight.bold, TextAlign.start),
                          text("Verified : ${builder.countAssign.finish}", 14,
                              Colors.green, FontWeight.bold, TextAlign.start),
                          text(
                              "Not Verified : ${builder.countAssign.notFinish}",
                              14,
                              Colors.red,
                              FontWeight.bold,
                              TextAlign.start),
                        ],
                      ),
                      const Divider(),
                      cardNavigation(Routes.CLEANING_DATA, "Riwayat Cleaning"),
                      const Divider(),
                      const Gap(10),
                      text("Menunggu Verifikasi", 20, Colors.black87,
                          FontWeight.bold, TextAlign.start),
                      const Gap(10),
                      finishAssign.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Center(
                                child:
                                    Text("Tidak Ada Yang Perlu di Verifikasi"),
                              ),
                            )
                          : Column(
                              children: finishAssign.map((e) {
                                return cardAssignDanone(
                                  e.codeCS!,
                                  e.location!.name!,
                                  e.area!.name!,
                                  e.assignBy!.name!,
                                  e.id!,
                                  e.status!,
                                );
                              }).toList(),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.scanQR(),
        backgroundColor: Colors.deepOrange.shade300,
        child: const Icon(
          Icons.qr_code_scanner_outlined,
          color: Colors.black87,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
