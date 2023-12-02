import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/assestment/controllers/assestment_controller.dart';
import 'package:flutter_mobile_csms/app/modules/assestment/views/role_view/assestment_leader.dart';
import 'package:flutter_mobile_csms/app/routes/app_pages.dart';
import 'package:flutter_mobile_csms/app/widgets/card.dart';
import 'package:flutter_mobile_csms/app/widgets/loading.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

class AssestmentView extends GetView<AssestmentController> {
  const AssestmentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Assessment'),
          centerTitle: true,
        ),
        body: GetBuilder<AssestmentController>(builder: (builder) {
          return LoadingOverlayPro(
            isLoading: builder.isLoading.value,
            progressIndicator: loading(),
            child: Container(
              padding: const EdgeInsets.all(20),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text("Halaman Pengamatan - Coaching Program", 18,
                        Colors.black87, FontWeight.bold, TextAlign.start),
                    const Gap(10),
                    cardNavigation(
                        Routes.ASSESTMENT_PENILAIAN, "Lihat Penilaian"),
                    const Divider(),
                    const Gap(20),
                    text("Berikan Penilaian", 16, Colors.black87,
                        FontWeight.bold, TextAlign.start),
                    assestmentLeader(
                      builder,
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
