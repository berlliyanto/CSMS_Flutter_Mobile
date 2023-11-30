import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningData/widgets/datatable_CD.dart';
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
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: DropdownMenu(
                          onSelected: (value) {
                            controller.source.setStatus(value!);
                            builder.update();
                          },
                          width: Get.width * 0.94,
                          hintText: "Pilih Status",
                          dropdownMenuEntries: const [
                            DropdownMenuEntry(
                                value: "Pending", label: "Pending"),
                            DropdownMenuEntry(
                                value: "On Progress", label: "On Progress"),
                            DropdownMenuEntry(value: "Finish", label: "Finish"),
                            DropdownMenuEntry(
                                value: "Not Finish", label: "Not Finish")
                          ]),
                    ),
                    const Gap(10),
                    TextField(
                      onChanged: (text) {
                        controller.source.setFilter(text);
                        controller.update();
                      },
                      decoration: InputDecoration(
                        labelText: 'Cari Cleaner',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const Gap(10),
                    datatableCD(builder)
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
