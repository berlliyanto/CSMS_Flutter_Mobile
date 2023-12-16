import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/models/user_model.dart';
import 'package:flutter_mobile_csms/app/modules/assestmentPenilaian/widgets/datatable_AP.dart';
import 'package:flutter_mobile_csms/app/widgets/dropdown.dart';
import 'package:flutter_mobile_csms/app/widgets/loading.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

import '../controllers/assestment_penilaian_controller.dart';

class AssestmentPenilaianView extends GetView<AssestmentPenilaianController> {
  const AssestmentPenilaianView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Assessment Cleaner'),
        centerTitle: true,
      ),
      body: GetBuilder<AssestmentPenilaianController>(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text("Pilih Cleaner", 14, Colors.black87, FontWeight.bold,
                        TextAlign.start),
                    const Gap(10),
                    dropdown(
                        const Key("cleaners"),
                        builder.cleaners,
                        "Pilih Cleaner",
                        "Cleaner",
                        (UserModel model) => model.name.toString(),
                        (UserModel model) => model.id.toString(),
                        (selected) {
                      final id = selected.map((e) => e.value);
                      final newId = id.isNotEmpty ? id.first : 0;
                      builder.cleanersSelected.value =
                          int.parse(newId.toString());
                      if (newId != 0) {
                        builder.fetchCalculateAssessment(
                            int.parse(newId.toString()));
                      }
                      builder.update();
                    }),
                    const Gap(20),
                    builder.cleanersSelected.value == 0
                        ? Center(
                            child: text(
                                "Silahkan pilih cleaner dahulu",
                                20,
                                Colors.black87,
                                FontWeight.bold,
                                TextAlign.center),
                          )
                        : datatableAP(builder)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
