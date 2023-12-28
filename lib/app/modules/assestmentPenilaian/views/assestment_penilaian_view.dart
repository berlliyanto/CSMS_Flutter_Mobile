import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/assestmentPenilaian/widgets/datatable_AP.dart';
import 'package:flutter_mobile_csms/app/widgets/button.dart';
import 'package:flutter_mobile_csms/app/widgets/filter.dart';
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
          return RefreshIndicator(
            onRefresh: () async {
              builder.refetch();
              builder.source.setCleaner("");
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text("Pilih Cleaner", 14, Colors.black87, FontWeight.bold,
                          TextAlign.start),
                      const Gap(10),
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
                                builder.source.setCleaner(value!);
                                builder.update();
                              },
                              width: Get.width * 0.89,
                              hintText: "Pilih Cleaner",
                              dropdownMenuEntries: builder.cleaners.map((e) {
                                return DropdownMenuEntry(
                                  value: e.name!.toString(),
                                  label: e.name!.toString(),
                                );
                              }).toList(),
                            ),
                            const Gap(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                text("Filter Tanggal", 14, Colors.black87,
                                    FontWeight.normal, TextAlign.start),
                                const Tooltip(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  message:
                                      "Tipe Filter (Tanggal Awal dan Akhir harus diisi)\n-Harian akan dipilih dari tanggal awal.\n-Bulanan akan dipilih dari rentang waktu antara tanggal awal dan tanggal akhir.\n-Tahunan akan dipilih dari tanggal awal.",
                                  child: Icon(Icons.info_outline, size: 20, color: Colors.orange,),
                                )
                              ],
                            ),
                            const Gap(5),
                            filterByDate(
                              FilterByDateProps(
                                tipe: builder.tipeFilter.value,
                                startDate: builder.startDate,
                                endDate: builder.endDate,
                                formattedStartDate:
                                    builder.formatedStartDate.value,
                                formattedEndDate: builder.formatedEndDate.value,
                                onChangeDropdown: (value) {
                                  builder.tipeFilter.value = value!;
                                  builder.update();
                                },
                                onFilterStartDate: () =>
                                    builder.selectStartDate(context),
                                onFilterEndDate: () =>
                                    builder.selectEndDate(context),
                              ),
                            ),
                            const Gap(10),
                            customButton("Terapkan", Colors.orange, 5, 10,
                                () => builder.getFilteredAssignByDate())
                          ],
                        ),
                      ),
                      datatableAP(builder)
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
