import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningData/widgets/datatable_CDA.dart';
import 'package:flutter_mobile_csms/app/widgets/loading.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

import '../controllers/cleaning_data_controller.dart';

class CleaningDataView extends GetView<CleaningDataController> {
  const CleaningDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cleaning Data'),
        centerTitle: true,
      ),
      body: GetBuilder<CleaningDataController>(
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
                    Center(
                      child: DropdownMenu(
                          onSelected: (value) {
                            builder.sourceAssignment.setLokasi(value!);
                            builder.update();
                          },
                          width: Get.width * 0.94,
                          hintText: "Pilih Lokasi",
                          dropdownMenuEntries: const [
                            DropdownMenuEntry(
                                value: "Wonoboyo", label: "Wonoboyo"),
                            DropdownMenuEntry(
                                value: "Kemudo", label: "Kemudo"),
                            DropdownMenuEntry(
                                value: "Jombor", label: "Jombor"),
                            DropdownMenuEntry(
                                value: "clear", label: "No Filter"),
                          ]),
                    ),
                    const Gap(10),
                    Center(
                      child: DropdownMenu(
                          onSelected: (value) {
                            builder.sourceAssignment.setStatus(value!);
                            builder.update();
                          },
                          width: Get.width * 0.94,
                          hintText: "Pilih Status",
                          dropdownMenuEntries: const [
                            DropdownMenuEntry(
                                value: "supervisor", label: "Belum verifikasi Supervisor"),
                            DropdownMenuEntry(
                                value: "danone", label: "Belum verifikasi Danone"),
                            DropdownMenuEntry(
                                value: "clear", label: "No Filter"),
                          ]),
                    ),
                    const Gap(10),
                    TextField(
                      onChanged: (text) {
                        builder.sourceAssignment.setFilter(text);
                        builder.update();
                      },
                      decoration: InputDecoration(
                        labelText: 'Cari',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const Gap(10),
                    // datatableCDT(builder)
                    datatableCDA(builder)
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
