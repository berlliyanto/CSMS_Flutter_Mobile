import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/report/controllers/cr_controller.dart';
import 'package:flutter_mobile_csms/app/widgets/button.dart';
import 'package:flutter_mobile_csms/app/widgets/filter.dart';
import 'package:flutter_mobile_csms/app/widgets/indicator.dart';
import 'package:flutter_mobile_csms/app/widgets/loading.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

class CleaningReport extends StatelessWidget {
  CleaningReport({super.key});

  final crController = Get.put(CleaningReportController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CleaningReportController>(builder: (controller) {
      return LoadingOverlayPro(
        isLoading: controller.isLoading.value,
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
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          text("Analytics", 18, Colors.black87, FontWeight.bold,
                              TextAlign.start),
                          const Tooltip(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            message:
                                "Tipe Filter (Tanggal Awal dan Akhir harus diisi)\n-Harian akan dipilih dari tanggal awal.\n-Bulanan akan dipilih dari rentang waktu antara tanggal awal dan tanggal akhir.\n-Tahunan akan dipilih dari tanggal awal.",
                            child: Icon(
                              Icons.info_outline,
                              size: 20,
                              color: Colors.orange,
                            ),
                          )
                        ],
                      ),
                      const Divider(),
                      Obx(
                        () => text(
                            "Analisis ${crController.currentAnalyticsStatus}",
                            16,
                            Colors.black87,
                            FontWeight.normal,
                            TextAlign.center),
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Indicator(
                            color: Colors.orange,
                            text: 'On Progress',
                            isSquare: false,
                            size: controller.touchedIndex.value == 0 ? 18 : 16,
                            textColor: controller.touchedIndex.value == 0
                                ? Colors.orange
                                : Colors.grey,
                          ),
                          Indicator(
                            color: Colors.green,
                            text: 'Finish',
                            isSquare: false,
                            size: controller.touchedIndex.value == 1 ? 18 : 16,
                            textColor: controller.touchedIndex.value == 1
                                ? Colors.green
                                : Colors.grey,
                          ),
                          Indicator(
                            color: Colors.red,
                            text: 'Not Finish',
                            isSquare: false,
                            size: controller.touchedIndex.value == 2 ? 18 : 16,
                            textColor: controller.touchedIndex.value == 2
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ],
                      ),
                      const Gap(10),
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: controller.assignAnalytics.total == 0
                            ? Center(
                                child: text(
                                    "Tidak Ada Data",
                                    20,
                                    Colors.black87,
                                    FontWeight.bold,
                                    TextAlign.center),
                              )
                            : PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(
                                    touchCallback:
                                        (FlTouchEvent event, pieTouchResponse) {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        controller.touchedIndex.value = -1;
                                        return;
                                      }
                                      controller.touchedIndex.value =
                                          pieTouchResponse.touchedSection!
                                              .touchedSectionIndex;
                                      controller.update();
                                    },
                                  ),
                                  borderData: FlBorderData(show: false),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 0,
                                  sections: controller.showingSections(),
                                ),
                              ),
                      ),
                      const Gap(10),
                      Flex(
                        direction: Axis.vertical,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          text(
                                              "Total Cleaning",
                                              10,
                                              Colors.blue,
                                              FontWeight.bold,
                                              TextAlign.start),
                                          const Icon(
                                            Icons.countertops_outlined,
                                            size: 16,
                                            color: Colors.blue,
                                          )
                                        ],
                                      ),
                                      const Gap(3),
                                      text(
                                          "${crController.assignAnalytics.total}",
                                          18,
                                          Colors.blue,
                                          FontWeight.bold,
                                          TextAlign.start),
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          text("On Progress", 10, Colors.orange,
                                              FontWeight.bold, TextAlign.start),
                                          const Icon(
                                            Icons.circle_outlined,
                                            size: 16,
                                            color: Colors.orange,
                                          )
                                        ],
                                      ),
                                      const Gap(3),
                                      text(
                                          "${crController.assignAnalytics.statusOnProgress}",
                                          18,
                                          Colors.orange,
                                          FontWeight.bold,
                                          TextAlign.start),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          text("Finish", 10, Colors.green,
                                              FontWeight.bold, TextAlign.start),
                                          const Icon(
                                            Icons.flag_outlined,
                                            size: 16,
                                            color: Colors.green,
                                          )
                                        ],
                                      ),
                                      const Gap(3),
                                      text(
                                          "${crController.assignAnalytics.statusFinish}",
                                          18,
                                          Colors.green,
                                          FontWeight.bold,
                                          TextAlign.start),
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          text("Not Finish", 10, Colors.red,
                                              FontWeight.bold, TextAlign.start),
                                          const Icon(
                                            Icons.cancel_presentation,
                                            size: 16,
                                            color: Colors.red,
                                          )
                                        ],
                                      ),
                                      const Gap(3),
                                      text(
                                          "${crController.assignAnalytics.statusNotFinish}",
                                          18,
                                          Colors.red,
                                          FontWeight.bold,
                                          TextAlign.start),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(),
                      filterByDate(
                        FilterByDateProps(
                          tipe: controller.tipeFilter.value,
                          startDate: controller.startDate,
                          endDate: controller.endDate,
                          formattedStartDate:
                              controller.formatedStartDate.value,
                          formattedEndDate: controller.formatedEndDate.value,
                          onChangeDropdown: (value) {
                            controller.tipeFilter.value = value!;
                            controller.update();
                          },
                          onFilterStartDate: () =>
                              controller.selectStartDate(context),
                          onFilterEndDate: () =>
                              controller.selectEndDate(context),
                        ),
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownMenu(
                            width: Get.width * 0.60,
                            hintText: "Lokasi",
                            enabled: !controller.isLocationAll.value,
                            onSelected: (value) => controller.location.value = value!,
                            dropdownMenuEntries: controller.locations
                                .map(
                                  (e) => DropdownMenuEntry(
                                      value: e.id, label: e.name!),
                                )
                                .toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  semanticLabel: "Semua Lokasi",
                                  value: controller.isLocationAll.value,
                                  onChanged: (value) {
                                    controller.isLocationAll.value = value!;
                                    controller.update();
                                  },
                                ),
                                const Text(
                                  "Semua Lokasi",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const Gap(10),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                        child:
                            customButton("Terapkan", Colors.blue, 5, 10, () => controller.refetchAssignmentAnalytics()),
                      ),
                      const Gap(10),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                        child: customButton(
                            "Export to Excel", Colors.green, 5, 10, () => controller.exportToExcel()),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
