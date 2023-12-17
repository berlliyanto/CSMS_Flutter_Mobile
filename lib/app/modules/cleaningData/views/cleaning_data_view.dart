import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningData/widgets/datatable_CDA.dart';
import 'package:flutter_mobile_csms/app/widgets/button.dart';
import 'package:flutter_mobile_csms/app/widgets/filter.dart';
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
          return RefreshIndicator(
            onRefresh: () async {
              builder.refetch();
            },
            child: LoadingOverlayPro(
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
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black54, width: 1),
                        ),
                        child: ExpansionTile(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          collapsedShape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          collapsedBackgroundColor: Colors.transparent,
                          iconColor: Colors.black54,
                          backgroundColor: Colors.transparent,
                          maintainState: true,
                          childrenPadding: const EdgeInsets.all(8),
                          title: const Text(
                            "Opsi Filter",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,
                            ),
                          ),
                          children: [
                            DropdownMenu(
                                onSelected: (value) {
                                  builder.sourceAssignment.setLokasi(value!);
                                  builder.update();
                                },
                                width: Get.width * 0.89,
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
                            const Gap(10),
                            DropdownMenu(
                                onSelected: (value) {
                                  builder.sourceAssignment.setStatus(value!);
                                  builder.update();
                                },
                                width: Get.width * 0.89,
                                hintText: "Pilih Status",
                                dropdownMenuEntries: const [
                                  DropdownMenuEntry(
                                      value: "supervisor",
                                      label: "Belum verifikasi Supervisor"),
                                  DropdownMenuEntry(
                                      value: "danone",
                                      label: "Belum verifikasi Danone"),
                                  DropdownMenuEntry(
                                      value: "clear", label: "No Filter"),
                                ]),
                            const Gap(10),
                            filterByDate(
                              FilterByDateProps(
                                  tipe: builder.tipeFilter.value,
                                  startDate: builder.startDate,
                                  endDate: builder.endDate,
                                  formattedStartDate:
                                      builder.formatedStartDate.value,
                                  formattedEndDate:
                                      builder.formatedEndDate.value,
                                  onChangeDropdown: (value) {
                                    builder.tipeFilter.value = value!;
                                    builder.update();
                                  },
                                  onFilterStartDate: () =>
                                      builder.selectStartDate(context),
                                  onFilterEndDate: () =>
                                      builder.selectEndDate(context)),
                            ),
                            const Gap(10),
                            customButton("Terapkan", Colors.blue, 5, 10,
                                () => builder.getFilteredAssignByDate())
                          ],
                        ),
                      ),
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
            ),
          );
        },
      ),
    );
  }
}
